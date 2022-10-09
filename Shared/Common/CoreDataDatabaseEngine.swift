//
//  CoreDataDatabaseEngine.swift
//  Code
//
//  Created by Henk van der Spek on 10/06/2022.
//

import CoreData

class CoreDataDatabaseEngine: DatabaseQuerying {
    var databaseId: String {
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
