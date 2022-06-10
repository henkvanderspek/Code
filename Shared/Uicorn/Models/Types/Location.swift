//
//  Location.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import Foundation

extension Uicorn {
    class Location: Codable {
        var name: String
        var coordinate: Uicorn.Coordinate
        init(name n: String, coordinate c: Uicorn.Coordinate) {
            name = n
            coordinate = c
        }
    }
}

extension Uicorn.Location {
    static var eiffelTower: Uicorn.Location {
        .init(name: "Eiffel Tower", coordinate: .eiffelTower)
    }
    static var mock: Uicorn.Location {
        eiffelTower
    }
    convenience init(_ c: Uicorn.Coordinate) {
        self.init(name: .init(), coordinate: c)
    }
}

extension Uicorn.Location: Equatable {
    static func == (lhs: Uicorn.Location, rhs: Uicorn.Location) -> Bool {
        lhs.name == rhs.name && lhs.coordinate == rhs.coordinate
    }
}

extension Uicorn.Location: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(coordinate)
    }
}
