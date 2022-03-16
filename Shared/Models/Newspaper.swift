//
//  Newspaper.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import Foundation

struct Newspaper {
    let issues: [Issue]
}

extension Newspaper {
    func issue(from date: Date) -> Issue? {
        let c = Calendar.current
        return issues.first(where: { c.compare(date, to: $0.date, toGranularity: .day) == .orderedSame })
    }
    var dateRange: ClosedRange<Date>? {
        guard let first = issues.first?.date, let last = issues.last?.date else { return nil }
        return last...first
    }
    var latestIssue: Issue? {
        issues.first
    }
}

extension Newspaper {
    static var mock: Self {
        let d1 = Date(timeIntervalSinceNow: .days(0))
        let d2 = Date(timeIntervalSinceNow: .days(-1))
        let d3 = Date(timeIntervalSinceNow: .days(-2))
        let d4 = Date(timeIntervalSinceNow: .days(-3))
        return .init(
            issues: [
                .init(
                    date: d1,
                    articles: [
                        .mock2(date: d1),
                        .mock3(date: d1),
                        .mock4(date: d1),
                        .mock5(date: d1)
                    ]
                ),
                .init(
                    date: d2,
                    articles: [
                        .mock3(date: d2),
                        .mock4(date: d2),
                        .mock5(date: d2),
                        .mock2(date: d2)
                    ]
                ),
                .init(
                    date: d3,
                    articles: [
                        .mock4(date: d3),
                        .mock5(date: d3),
                        .mock2(date: d3),
                        .mock3(date: d3)
                    ]
                ),
                .init(
                    date: d4,
                    articles: [
                        .mock5(date: d4),
                        .mock2(date: d4),
                        .mock3(date: d4),
                        .mock4(date: d4)
                    ]
                )
            ]
        )
    }
}

extension TimeInterval {
    static var day: Self {
        60 * 60 * 24
    }
    static func days(_ v: Int) -> Self {
        day * TimeInterval(v)
    }
}
