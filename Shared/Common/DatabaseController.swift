//
//  DatabaseController.swift
//  Code
//
//  Created by Henk van der Spek on 05/06/2022.
//

import Foundation

protocol DatabaseQuerying {
    typealias Database = Uicorn.Database
    var databaseId: String { get }
    var entities: [Database.Entity] { get }
    func entity(by id: String) -> Database.Entity?
    func records(byEntity id: String) -> [Database.Record]?
    func store(entityId: String, _ record: Database.Record)
}

class DatabaseController: ObservableObject {
    enum Configuration {
        case mock
        case dev
        case live
    }
    let configuration: Configuration
    private lazy var engine: DatabaseQuerying = {
        switch configuration {
        case .mock:
            return MockDatabaseEngine()
        case .dev, .live:
            fatalError()
        }
    }()
    init(configuration c: Configuration) {
        configuration = c
    }
}

extension DatabaseController: DatabaseQuerying {
    var databaseId: String {
        engine.databaseId
    }
    var entities: [Database.Entity] {
        engine.entities
    }
    func entity(by id: String) -> Database.Entity? {
        engine.entity(by: id)
    }
    func records(byEntity id: String) -> [Database.Record]? {
        engine.records(byEntity: id)
    }
    func store(entityId: String, _ record: Database.Record) {
        engine.store(entityId: entityId, record)
    }
}

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
