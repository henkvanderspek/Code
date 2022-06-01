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
    static var appleStoreSoHo: Uicorn.Coordinate {
        .init(40.72547452077477, -73.99895645460768)
    }
    static var eiffelTower: Uicorn.Coordinate {
        .init(48.85901957930565, 2.294606993956224)
    }
    static var zanzibarBeachclub: Uicorn.Coordinate {
        .init(52.113456583059126, 4.279874927463718)
    }
}
