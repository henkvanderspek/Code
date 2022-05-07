//
//  Reference.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import Foundation

struct Reference {
    let id: String
    let title: String
}

extension Reference: Hashable {
    static func == (lhs: Reference, rhs: Reference) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Reference {
    static var empty: Self {
        return .init(id: .init(), title: .init())
    }
}
