//
//  Issue.swift
//  Code
//
//  Created by Henk van der Spek on 16/03/2022.
//

import Foundation

struct Issue {
    let id = UUID()
    let date: Date
    let articles: [Article]
}

extension Issue: Identifiable {}

extension Issue: Equatable {
    static func == (lhs: Issue, rhs: Issue) -> Bool {
        lhs.id == rhs.id
    }
}

extension Issue {
    static var mock: Self {
        mock(date: .now)
    }
    static func mock(date: Date) -> Self {
        .init(
            date: date,
            articles: [
                .mock(date: date),
                .mock(date: date),
                .mock(date: date),
                .mock(date: date)
            ]
        )
    }
}

extension Issue {
    var relativeDateString: String {
        CustomFormatter.relativeString(from: date)
    }
}
