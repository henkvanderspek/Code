//
//  Newspaper.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import Foundation

struct Newspaper {
    let date: Date
    let posts: [Post]
}

extension Newspaper {
    static var mock: Self {
        .init(
            date: .now,
            posts: [
                .mock,
                .mock,
                .mock,
                .mock
            ]
        )
    }
}
