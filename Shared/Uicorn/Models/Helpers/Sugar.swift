//
//  Sugar.swift
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
    static func text(_ s: String, font: Uicorn.Font = .default, alignment: Uicorn.TextAlignment = .leading, textCase: Uicorn.TextCase = .standard, foregroundColor: Uicorn.Color? = nil, action: Action? = nil, properties: Uicorn.Properties? = nil) -> Uicorn.View {
        .init(id: .unique, type: .text(.init(s, font: font, alignment: alignment, textCase: textCase, foregroundColor: foregroundColor)), action: action, properties: properties)
    }
    static func hstack(_ c: [Uicorn.View], alignment: Uicorn.VerticalAlignment = .center, spacing: Int = 0, action: Action? = nil, properties: Uicorn.Properties? = nil) -> Uicorn.View {
        .init(id: .unique, type: .hstack(.init(c, alignment: alignment, spacing: spacing)), action: action, properties: properties)
    }
    static func vstack(_ c: [Uicorn.View], alignment: Uicorn.HorizontalAlignment = .center, spacing: Int = 0, action: Action? = nil, properties: Uicorn.Properties? = nil) -> Uicorn.View {
        .init(id: .unique, type: .vstack(.init(c, alignment: alignment, spacing: spacing)), action: action, properties: properties)
    }
    static func zstack(_ c: [Uicorn.View], action: Action? = nil, properties: Uicorn.Properties? = nil) -> Uicorn.View {
        .init(id: .unique, type: .zstack(.init(c)), action: action, properties: properties)
    }
    static var hstack: Uicorn.View {
        .hstack([])
    }
    static var vstack: Uicorn.View {
        .vstack([])
    }
    static var zstack: Uicorn.View {
        .zstack([])
    }
    static func image(_ s: String, id: String = .unique, action: Action? = nil, properties: Uicorn.Properties? = nil) -> Uicorn.View {
        .init(id: id, type: .image(.remote(s)), action: action, properties: properties)
    }
    static func image(_ s: String, id: String = .unique, fill: Uicorn.Color?, type: Uicorn.Font.`Type` = .body, weight: Uicorn.Font.Weight = .regular, scale: Uicorn.ImageScale = .large, action: Action? = nil, properties: Uicorn.Properties? = nil) -> Uicorn.View {
        .init(id: id, type: .image(.system(name: s, fill: fill, type: type, weight: weight, scale: scale)), action: action, properties: properties)
    }
    static func sfSymbol(_ s: String, id: String = .unique, fill: Uicorn.Color? = nil, type: Uicorn.Font.`Type` = .body, weight: Uicorn.Font.Weight = .regular, scale: Uicorn.ImageScale = .large, properties: Uicorn.Properties? = nil) -> Uicorn.View {
        .image(s, id: id, fill: fill, type: type, weight: weight, scale: scale, properties: properties)
    }
    static var randomSystemImage: Uicorn.View {
        .randomSystemImage()
    }
    static func randomSystemImage(fill: Uicorn.Color? = nil, action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .image(.randomSystem(fill: fill)), action: action, properties: nil)
    }
    static var randomRemoteImage: Uicorn.View {
        randomRemoteImage()
    }
    static func randomRemoteImage(action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .image(.randomRemote), action: action, properties: nil)
    }
    static func unsplash(_ q: String?, count c: Int? = nil) -> Uicorn.View {
        .init(id: .unique, type: .collection(.unsplash(q, count: c)), action: nil, properties: nil)
    }
    static var unsplash: Uicorn.View {
        .unsplash(nil)
    }
    static var rectangle: Uicorn.View {
        .rectangle(.system(.yellow))
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
    static var map: Uicorn.View {
        .init(id: .unique, type: .map(.init()), action: nil, properties: nil)
    }
    static func hscroll(_ c: [Uicorn.View]) -> Uicorn.View {
        .init(id: .unique, type: .scroll(.init(axis: .horizontal, children: c)), action: nil, properties: nil)
    }
    static func vscroll(_ c: [Uicorn.View]) -> Uicorn.View {
        .init(id: .unique, type: .scroll(.init(axis: .vertical, children: c)), action: nil, properties: nil)
    }
    static var hscroll: Uicorn.View {
        .hscroll([])
    }
    static var vscroll: Uicorn.View {
        .vscroll([])
    }
    static func instance(_ id: String, values: Uicorn.View.Instance.Values) -> Uicorn.View {
        .init(id: .unique, type: .instance(.init(id: .unique, componentId: id, values: values)), action: nil, properties: nil)
    }
    static func postInstance(values: Uicorn.View.Instance.Values) -> Uicorn.View {
        .instance(.postComponentId, values: values)
    }
    static var postInstance: Uicorn.View {
        .postInstance(values: [:])
    }
}

extension Uicorn.View.Collection {
    static func unsplash(_ q: String?, count c: Int? = nil) -> Uicorn.View.Collection {
        .init(type: .unsplash, parameters: ["query":q, "count":c.map { .init($0) }], view: .image("{{url}}", action: .presentSelf))
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
        .init(type: .presentSelf)
    }
}

extension String {
    static func random(of e: [String]) -> String {
        e.randomElement()!
    }
}
