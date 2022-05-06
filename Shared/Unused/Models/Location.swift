//
//  Location.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import Foundation

struct Location: Identifiable {
    let id = UUID()
    let title: String
    let coordinate: Coordinate
    init(title t: String, coordinate c: Coordinate = .zero) {
        title = t
        coordinate = c
    }
}

extension Location {
    static var appleStoreSoho: Self {
        .init(title: "Apple Store SoHo", coordinate: .appleStoreSoHo)
    }
    static var eiffelTower: Self {
        .init(title: "Eiffel Tower", coordinate: .eiffelTower)
    }
    static var zanzibarBeachclub: Self {
        .init(title: "Zanzibar Beachclub", coordinate: .zanzibarBeachclub)
    }
    static var mock: Self {
        appleStoreSoho
    }
    static var mock2: Self {
        eiffelTower
    }
}
