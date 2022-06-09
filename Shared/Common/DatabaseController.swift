//
//  DatabaseController.swift
//  Code
//
//  Created by Henk van der Spek on 05/06/2022.
//

import Foundation

class DatabaseController: ObservableObject {
    typealias Database = Uicorn.Database
    enum Configuration {
        case dev
        case live
    }
    let configuration: Configuration
    private lazy var database: Database = {
        .mock
    }()
    init(configuration c: Configuration) {
        configuration = c
    }
    var databaseId: String {
        database.id
    }
    var entities: [Database.Entity] {
        switch configuration {
        case .dev:
            return database.entities
        case .live:
            fatalError()
        }
    }
    func entity(by id: String) -> Database.Entity? {
        switch configuration {
        case .dev:
            return database.entities.first(where: { $0.id == id })
        case .live:
            fatalError()
        }
    }
    func records(byEntity id: String) -> [Database.Record]? {
        guard let e = entity(by: id) else { return nil }
        switch configuration {
        case .dev:
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
        case .live:
            fatalError()
        }
    }
    func store(entityId: String, _ record: Database.Record) {
        switch configuration {
        case .dev:
            database.store(entityId: entityId, record)
        case .live:
            fatalError()
        }
    }
}
