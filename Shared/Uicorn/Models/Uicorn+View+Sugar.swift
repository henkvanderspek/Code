//
//  Uicorn+View+Sugar.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import Foundation

extension Uicorn.View {
    static var empty: Uicorn.View {
        .init(id: .unique, type: .empty)
    }
    static var spacer: Uicorn.View {
        .init(id: .unique, type: .spacer)
    }
    static func text(_ s: String) -> Uicorn.View {
        .init(id: .unique, type: .text(.init(s)))
    }
    static func hstack(_ c: [Uicorn.View], spacing: Int = 0) -> Uicorn.View {
        .init(id: .unique, type: .hstack(.init(c, spacing: spacing)))
    }
    static func vstack(_ c: [Uicorn.View], spacing: Int = 0) -> Uicorn.View {
        .init(id: .unique, type: .vstack(.init(c, spacing: spacing)))
    }
    static func zstack(_ c: [Uicorn.View]) -> Uicorn.View {
        .init(id: .unique, type: .zstack(.init(c)))
    }
    static func image(_ s: String) -> Uicorn.View {
        .init(id: .unique, type: .image(.init(type: .remote, value: s)))
    }
    static func unsplash(_ q: String?, count c: Int? = 100) -> Uicorn.View {
        .init(id: .unique, type: .collection(.init(type: .unsplash, parameters: ["query":q, "count":c.map { .init($0) }], view: .image("{{url}}"))))
    }
}
