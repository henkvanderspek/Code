//
//  MockDatabaseEngine.swift
//  Code
//
//  Created by Henk van der Spek on 10/06/2022.
//

import Foundation

class MockDatabaseEngine: DatabaseQuerying {
    private lazy var database: Database = {
        .mock
    }()
    var databaseId: String {
        database.id
    }
    var entities: [Database.Entity] {
        database.entities
    }
    func entity(by id: String) -> Database.Entity? {
        database.entities.first(where: { $0.id == id })
    }
    func records(byEntity id: String) -> [Database.Record]? {
        guard let e = entity(by: id) else { return nil }
        return database
            .values
            .filter { value in
                value.entityId == id && e.attributes.contains(where: { $0.id == value.attributeId })
            }
            .reduce(into: [:]) { result, value in
                guard let a = e.attributes.first(where: { $0.id == value.attributeId }) else { return }
                guard let v = Database.Record.Value(value, attribute: a) else { return }
                result[value.rowId, default: []].append(v)
            }
            .map {
                .init(rowId: $0.key, values: $0.value)
            }
            .sorted {
                $0.rowId < $1.rowId
            }
    }
    func store(entityId: String, _ record: Database.Record) {
        database.store(entityId: entityId, record)
    }
}
