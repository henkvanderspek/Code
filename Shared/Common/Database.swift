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
                let attributeId: String
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
            self = .init(attribute.id, v.value)
        case .int:
            guard let v = Int(v.value) else { return nil }
            self = .init(attribute.id, v)
        case .double:
            guard let v = Double(v.value) else { return nil }
            self = .init(attribute.id, v)
        case .boolean:
            guard let v = Bool(v.value) else { return nil }
            self = .init(attribute.id, v)
        case .coordinate:
            guard let d = v.value.data(using: .utf8), let c = try? JSONDecoder().decode(Uicorn.Coordinate.self, from: d) else { return nil }
            self = .init(attribute.id, c)
        }
    }
    init(_ a: String, _ v: String) {
        id = .unique
        attributeId = a
        type = .string(v)
    }
    init(_ a: String, _ v: Int) {
        id = .unique
        attributeId = a
        type = .int(v)
    }
    init(_ a: String, _ v: Double) {
        id = .unique
        attributeId = a
        type = .double(v)
    }
    init(_ a: String, _ v: Bool) {
        id = .unique
        attributeId = a
        type = .boolean(v)
    }
    init(_ a: String, _ v: Uicorn.Coordinate) {
        id = .unique
        attributeId = a
        type = .coordinate(v)
    }
    var string: String {
        type.string
    }
    var coordinate: Uicorn.Coordinate? {
        guard case let .coordinate(c) = type else { return nil }
        return c
    }
}

extension Uicorn.Database.Record.Value.`Type` {
    var string: String {
        switch self {
        case let .string(s): return s
        case let .int(i): return .init(i)
        case let .double(d): return .init(d)
        case let .boolean(b): return .init(b)
        case let .coordinate(c): return "\(c.latitude),\(c.longitude)"
        }
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
                .init(id: .unique, rowId: 2, entityId: .entityPlaceId, attributeId: .attributePlaceCoordinateId, coordinate: .louvre)!,
                .init(id: .unique, rowId: 3, entityId: .entityPlaceId, attributeId: .attributePlaceNameId, value: "Champs-Élysées - Clemenceau"),
                .init(id: .unique, rowId: 3, entityId: .entityPlaceId, attributeId: .attributePlaceCoordinateId, coordinate: .champsÉlyséesClemenceau)!
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
