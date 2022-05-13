//
//  Uicorn+View+Sugar.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import Foundation

extension Uicorn.View {
    static var empty: Uicorn.View {
        .init(id: .unique, type: .empty, action: nil, properties: nil)
    }
    static var spacer: Uicorn.View {
        .init(id: .unique, type: .spacer, action: nil, properties: nil)
    }
    static func text(_ s: String, action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .text(.init(s)), action: action, properties: nil)
    }
    static func hstack(_ c: [Uicorn.View], spacing: Int = 0) -> Uicorn.View {
        .init(id: .unique, type: .hstack(.init(c, spacing: spacing)), action: nil, properties: nil)
    }
    static func vstack(_ c: [Uicorn.View], spacing: Int = 0) -> Uicorn.View {
        .init(id: .unique, type: .vstack(.init(c, spacing: spacing)), action: nil, properties: nil)
    }
    static func zstack(_ c: [Uicorn.View]) -> Uicorn.View {
        .init(id: .unique, type: .zstack(.init(c)), action: nil, properties: nil)
    }
    static func image(_ s: String, action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .image(.init(type: .remote, value: s)), action: action, properties: nil)
    }
    static func unsplash(_ q: String?, count c: Int? = nil) -> Uicorn.View {
        .init(id: .unique, type: .collection(.unsplash(q, count: c)), action: nil, properties: nil)
    }
    static var rectangle: Uicorn.View {
        rectangle(.system(.yellow))
    }
    static func rectangle(_ c: Color) -> Uicorn.View {
        .init(id: .unique, type: .rectangle(.init(fill: c)), action: nil, properties: nil)
    }
    static var color: Uicorn.View {
        color(.system(.yellow))
    }
    static func color(_ ct: Color.ColorType) -> Uicorn.View {
        .init(id: .unique, type: .color(.init(ct)), action: nil, properties: nil)
    }
}

extension Uicorn.View.Collection {
    static func unsplash(_ q: String?, count c: Int? = nil) -> Uicorn.View.Collection {
        .init(type: .unsplash, parameters: ["query":q, "count":c.map { .init($0) }], view: .image("{{url}}", action: .presentSelf))
    }
}

extension Uicorn.View.Action {
    static var presentSelf: Uicorn.View.Action {
        .init(actionType: .presentSelf)
    }
}
