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
    static func text(_ s: String, font: Uicorn.Font = .default, action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .text(.init(s, font: font)), action: action, properties: nil)
    }
    static func hstack(_ c: [Uicorn.View], spacing: Int = 0) -> Uicorn.View {
        .init(id: .unique, type: .hstack(.init(c, spacing: spacing)), action: nil, properties: nil)
    }
    static func vstack(_ c: [Uicorn.View], spacing: Int = 0) -> Uicorn.View {
        .init(id: .unique, type: .vstack(.init(c, spacing: spacing)), action: nil, properties: nil)
    }
    static func zstack(_ c: [Uicorn.View], action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .zstack(.init(c)), action: action, properties: nil)
    }
    static func image(_ s: String, type: Image.`Type`, fill: Uicorn.Color? = nil, action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .image(.init(type: type, value: s, fill: fill)), action: action, properties: nil)
    }
    static func unsplash(_ q: String?, count c: Int? = nil) -> Uicorn.View {
        .init(id: .unique, type: .collection(.unsplash(q, count: c)), action: nil, properties: nil)
    }
    static var rectangle: Uicorn.View {
        rectangle(.system(.yellow))
    }
    static func rectangle(_ c: Uicorn.Color) -> Uicorn.View {
        .init(id: .unique, type: .shape(.rectangle(c)), action: nil, properties: nil)
    }
    static func ellipse(_ c: Uicorn.Color) -> Uicorn.View {
        .init(id: .unique, type: .shape(.ellipse(c)), action: nil, properties: nil)
    }
    static func capsule(_ c: Uicorn.Color) -> Uicorn.View {
        .init(id: .unique, type: .shape(.capsule(c)), action: nil, properties: nil)
    }
}

extension Uicorn.View.Collection {
    static func unsplash(_ q: String?, count c: Int? = nil) -> Uicorn.View.Collection {
        .init(type: .unsplash, parameters: ["query":q, "count":c.map { .init($0) }], view: .image("{{url}}", type: .remote, action: .presentSelf))
    }
}

extension Uicorn.View.Shape {
    static func rectangle(_ c: Uicorn.Color) -> Uicorn.View.Shape {
        .init(type: .rectangle, fill: c)
    }
    static func ellipse(_ c: Uicorn.Color) -> Uicorn.View.Shape {
        .init(type: .ellipse, fill: c)
    }
    static func capsule(_ c: Uicorn.Color) -> Uicorn.View.Shape {
        .init(type: .capsule, fill: c)
    }
}

extension Uicorn.View.Action {
    static var presentSelf: Uicorn.View.Action {
        .init(actionType: .presentSelf)
    }
}
