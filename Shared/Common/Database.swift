//
//  Database.swift
//  Code
//
//  Created by Henk van der Spek on 05/06/2022.
//

import Foundation

extension Uicorn {
    struct Database {
        struct Entity {
            let id: String
            let name: String
            let attributes: [Attribute]
        }
        struct Attribute {
            enum `Type` {
                case string
                case int
                case double
                case boolean
                case coordinate
            }
            let id: String
            let name: String
            let type: `Type`
            let param: String?
        }
        struct Value {
            let id: String
            let rowId: Int
            let entityId: String
            let attributeId: String
            let value: String
        }
        struct Record {
            struct Value {
                enum `Type` {
                    case string(String)
                    case int(Int)
                    case double(Double)
                    case boolean(Bool)
                    case coordinate(Uicorn.Coordinate)
                }
                let id: String
                let name: String
                let type: `Type`
            }
            let rowId: Int
            let values: [Value]
        }
        let id: String
        let entities: [Entity]
        let values: [Value]
    }
}

extension Uicorn.Database.Record.Value {
    init?(_ v: Uicorn.Database.Value, attribute: Uicorn.Database.Attribute) {
        switch attribute.type {
        case .string:
            self = .init(attribute.name, v.value)
        case .int:
            guard let v = Int(v.value) else { return nil }
            self = .init(attribute.name, v)
        case .double:
            guard let v = Double(v.value) else { return nil }
            self = .init(attribute.name, v)
        case .boolean:
            guard let v = Bool(v.value) else { return nil }
            self = .init(attribute.name, v)
        case .coordinate:
            guard let d = v.value.data(using: .utf8), let c = try? JSONDecoder().decode(Uicorn.Coordinate.self, from: d) else { return nil }
            self = .init(attribute.name, c)
        }
    }
    init(_ n: String, _ v: String) {
        id = .unique
        name = n
        type = .string(v)
    }
    init(_ n: String, _ v: Int) {
        id = .unique
        name = n
        type = .int(v)
    }
    init(_ n: String, _ v: Double) {
        id = .unique
        name = n
        type = .double(v)
    }
    init(_ n: String, _ v: Bool) {
        id = .unique
        name = n
        type = .boolean(v)
    }
    init(_ n: String, _ v: Uicorn.Coordinate) {
        id = .unique
        name = n
        type = .coordinate(v)
    }
}

extension Uicorn.Database.Value {
    init?(id: String, rowId: Int, entityId: String, attributeId: String, coordinate: Uicorn.Coordinate) {
        guard let d = try? JSONEncoder().encode(coordinate), let s = String(data: d, encoding: .utf8) else { return nil }
        self.init(id: id, rowId: rowId, entityId: entityId, attributeId: attributeId, value: s)
    }
}

extension Uicorn.Database {
    static var mock: Self {
        .init(
            id: .unique,
            entities: [
                .init(
                    id: .entityPlaceId,
                    name: "Places",
                    attributes: [
                        .init(id: .attributePlaceNameId, name: "Name", type: .string, param: nil),
                        .init(id: .attributePlaceCoordinateId, name: "Coordinate", type: .coordinate, param: nil),
                    ]
                )
            ],
            values: [
                .init(id: .unique, rowId: 1, entityId: .entityPlaceId, attributeId: .attributePlaceNameId, value: "Eiffel Tower"),
                .init(id: .unique, rowId: 1, entityId: .entityPlaceId, attributeId: .attributePlaceCoordinateId, coordinate: .eiffelTower)!,
                .init(id: .unique, rowId: 2, entityId: .entityPlaceId, attributeId: .attributePlaceNameId, value: "Louvre"),
                .init(id: .unique, rowId: 2, entityId: .entityPlaceId, attributeId: .attributePlaceCoordinateId, value: "{\"latitude\":48.8606111,\"longitude\":2.337644}"),
            ]
        )
    }
}

private extension String {
    static var entityPlaceId = "__entityPlaceId"
    static var entityCoordinateId = "__entityCoordinateId"
    static var attributePlaceNameId = "__attributePlaceNameId"
    static var attributePlaceCoordinateId = "__attributePlaceLocationId"
}
