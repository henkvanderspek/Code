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
