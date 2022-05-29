//
//  AppStoring.swift
//  macOS
//
//  Created by Henk van der Spek on 27/05/2022.
//

import Foundation
import CoreData

typealias EncodingCompletion = (Data?)->()

protocol AppStoring {
    func fetchApps() -> [Uicorn.App]
    func store(_ apps: [Uicorn.App], encoded: EncodingCompletion?)
    func store(_ app: Uicorn.App, encoded: EncodingCompletion?)
}

extension AppStoring {
    func store(_ apps: [Uicorn.App]) {
        store(apps, encoded: nil)
    }
    func store(_ app: Uicorn.App) {
        store(app, encoded: nil)
    }
}

class AppStorageCoreData {
    
    fileprivate enum `Type`: String {
        case app
    }

    @objc(Item)
    fileprivate class Item: NSManagedObject {
        @NSManaged var key: String?
        @NSManaged var type: String?
        @NSManaged var data: Data?
        @NSManaged var created: Date?
    }
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Cache", managedObjectModel: .cache)
        print(NSPersistentContainer.defaultDirectoryURL().absoluteString)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = container.viewContext
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()
}

extension AppStorageCoreData: AppStoring {
    func fetchApps() -> [Uicorn.App] {
        return fetchItems(type: .app).compactMap {
            $0.data.map { try? decoder.decode(Uicorn.App.self, from: $0) } ?? nil
        }
    }
    
    func store(_ apps: [Uicorn.App], encoded: EncodingCompletion?) {
        apps.forEach { store($0, save: false, encoded: encoded) }
        save()
    }
    
    func store(_ app: Uicorn.App, encoded: EncodingCompletion?) {
        store(app, save: true, encoded: encoded)
    }
}

private extension AppStorageCoreData {
    func store(_ app: Uicorn.App, save s: Bool, encoded: EncodingCompletion?) {
        let i = Item(context: context)
        i.key = app.id
        i.type = `Type`.app.rawValue
        i.data = try? encoder.encode(app)
        encoded?(i.data)
        guard s else { return }
        save()
    }
}

private extension AppStorageCoreData {
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
    
    func fetchItems(type: `Type`) -> [Item] {
        do {
            let fetch = NSFetchRequest<Item>(entityName: "Item")
            fetch.sortDescriptors = [.init(key: "created", ascending: false)]
            fetch.predicate = .init(format: "type LIKE %@", type.rawValue)
            return try context.fetch(fetch)
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
}

private extension NSManagedObjectModel {
    static var cache: NSManagedObjectModel {
        .init(entities: [.item])
    }
}

extension NSEntityDescription {
    static var item: NSEntityDescription {
        return .init(
            name: "Item",
            properties: [
                .string("key"),
                .string("type"),
                .binary("data"),
                .date("created"),
            ],
            uniquenessConstraints: [[
                "key"
            ]]
        )
    }
}
