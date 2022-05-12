//
//  Uicorn+View+Sugar.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import Foundation

extension Uicorn.View {
    static var empty: Uicorn.View {
        .init(id: .unique, type: .empty, action: nil)
    }
    static var spacer: Uicorn.View {
        .init(id: .unique, type: .spacer, action: nil)
    }
    static func text(_ s: String, action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .text(.init(s)), action: action)
    }
    static func hstack(_ c: [Uicorn.View], spacing: Int = 0) -> Uicorn.View {
        .init(id: .unique, type: .hstack(.init(c, spacing: spacing)), action: nil)
    }
    static func vstack(_ c: [Uicorn.View], spacing: Int = 0) -> Uicorn.View {
        .init(id: .unique, type: .vstack(.init(c, spacing: spacing)), action: nil)
    }
    static func zstack(_ c: [Uicorn.View]) -> Uicorn.View {
        .init(id: .unique, type: .zstack(.init(c)), action: nil)
    }
    static func image(_ s: String, action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .image(.init(type: .remote, value: s)), action: action)
    }
    static func unsplash(_ q: String?, count c: Int? = nil) -> Uicorn.View {
        .init(id: .unique, type: .collection(.unsplash(q, count: c)), action: nil)
    }
}

extension Uicorn.View.Collection {
    static func unsplash(_ q: String?, count c: Int? = nil) -> Uicorn.View.Collection {
        .init(type: .unsplash, parameters: ["query":q, "count":c.map { .init($0) }], view: .image("{{thumb}}", action: .presentSelf))
    }
}

extension Uicorn.View.Action {
    static var presentSelf: Uicorn.View.Action {
        .init(actionType: .presentSelf)
    }
}
