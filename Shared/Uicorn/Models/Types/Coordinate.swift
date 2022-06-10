//
//  Coordinate.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import Foundation

extension Uicorn {
    class Coordinate: Codable {
        var latitude: Double
        var longitude: Double
        init(_ lat: Double, _ lon: Double) {
            latitude = lat
            longitude = lon
        }
    }
}

extension Uicorn.Coordinate {
    static var zero: Uicorn.Coordinate {
        .init(0, 0)
    }
    static var eiffelTower: Uicorn.Coordinate {
        .init(48.8539054,2.2663311)
    }
    static var louvre: Uicorn.Coordinate {
        .init(48.8606111,2.3354553)
    }
    static var muséeRodin: Uicorn.Coordinate {
        .init(48.8660958,2.282997)
    }
    static var champsÉlysées: Uicorn.Coordinate {
        .init(48.8683078,2.3000002)
    }
}

extension Uicorn.Coordinate: Equatable {
    static func == (lhs: Uicorn.Coordinate, rhs: Uicorn.Coordinate) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension Uicorn.Coordinate: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}
