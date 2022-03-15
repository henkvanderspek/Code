//
//  CarouselItem.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import Foundation

struct CarouselItem {
    enum `Type` {
        case location(Location)
        case image(URL)
    }
    let id = UUID()
    let type: `Type`
}

extension CarouselItem {
    static func location(_ loc: Location) -> Self {
        .init(type: .location(loc))
    }
    static func image(_ u: URL) -> Self {
        .init(type: .image(u))
    }
}
