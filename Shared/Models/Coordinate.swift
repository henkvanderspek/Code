//
//  Coordinate.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
    init(_ lat: Double, _ lon: Double) {
        latitude = lat
        longitude = lon
    }
}

extension Coordinate {
    static var zero: Self {
        .init(0, 0)
    }
    static var appleStoreSoHo: Self {
        .init(40.72547452077477, -73.99895645460768)
    }
    static var eiffelTower: Self {
        .init(48.85901957930565, 2.294606993956224)
    }
    static var zanzibarBeachclub: Self {
        .init(52.113456583059126, 4.279874927463718)
    }
}
