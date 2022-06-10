//
//  CloudKitDatabaseEngine.swift
//  Code
//
//  Created by Henk van der Spek on 10/06/2022.
//

import CloudKit

class CloudKitDatabaseEngine: DatabaseQuerying {
    private lazy var database: CKDatabase = {
        CKContainer.default().publicCloudDatabase
    }()
    var databaseId: String {
        Task.init {
            let results = try? await database.records(matching: .database)
        }
        return .init()
    }
    var entities: [Database.Entity] {
        return []
    }
    func entity(by id: String) -> Database.Entity? {
        return nil
    }
    func records(byEntity id: String) -> [Database.Record]? {
        return nil
    }
    func store(entityId: String, _ record: Database.Record) {
    }
}

extension CKQuery {
    static var database: CKQuery {
        .init(recordType: "Database", predicate: .`true`)
    }
}

extension NSPredicate {
    static var `true`: Self {
        .init(value: true)
    }
}
