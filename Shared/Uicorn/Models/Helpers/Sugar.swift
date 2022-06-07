//
//  Sugar.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import Foundation

extension Uicorn.View {
    static var empty: Uicorn.View {
        .init(id: .unique, type: .empty, action: nil, modifiers: nil)
    }
    static var spacer: Uicorn.View {
        .init(id: .unique, type: .spacer, action: nil, modifiers: nil)
    }
    static func text(id: String = .unique, _ s: String = "", font: Uicorn.Font = .default, alignment: Uicorn.TextAlignment = .leading, textCase: Uicorn.TextCase = .standard, foregroundColor: Uicorn.Color? = nil, action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: id, type: .text(.init(s, font: font, alignment: alignment, textCase: textCase, foregroundColor: foregroundColor)), action: action, modifiers: modifiers)
    }
    static func hstack(_ c: [Uicorn.View], alignment: Uicorn.VerticalAlignment = .center, spacing: Int = 0, action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: .unique, type: .hstack(.init(c, alignment: alignment, spacing: spacing)), action: action, modifiers: modifiers)
    }
    static func vstack(_ c: [Uicorn.View], alignment: Uicorn.HorizontalAlignment = .center, spacing: Int = 0, action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: .unique, type: .vstack(.init(c, alignment: alignment, spacing: spacing)), action: action, modifiers: modifiers)
    }
    static func zstack(_ c: [Uicorn.View], action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: .unique, type: .zstack(.init(c)), action: action, modifiers: modifiers)
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
    static func image(id: String = .unique, _ i: Image, action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: id, type: .image(i), action: action, modifiers: modifiers)
    }
    static func image(id: String = .unique, _ s: String = "", action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: id, type: .image(.remote(s)), action: action, modifiers: modifiers)
    }
    static func image(id: String = .unique, _ s: String, fill: Uicorn.Color?, type: Uicorn.Font.`Type` = .body, weight: Uicorn.Font.Weight = .regular, scale: Uicorn.ImageScale = .large, action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: id, type: .image(.system(name: s, fill: fill, type: type, weight: weight, scale: scale)), action: action, modifiers: modifiers)
    }
    static func sfSymbol(id: String = .unique, _ s: String, fill: Uicorn.Color? = nil, type: Uicorn.Font.`Type` = .body, weight: Uicorn.Font.Weight = .regular, scale: Uicorn.ImageScale = .large, modifiers: Modifiers? = nil) -> Uicorn.View {
        .image(id: id, s, fill: fill, type: type, weight: weight, scale: scale, modifiers: modifiers)
    }
    static var randomSystemImage: Uicorn.View {
        .randomSystemImage()
    }
    static func randomSystemImage(fill: Uicorn.Color? = nil, action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: .unique, type: .image(.randomSystem(fill: fill)), action: action, modifiers: modifiers)
    }
    static var randomRemoteImage: Uicorn.View {
        randomRemoteImage()
    }
    static func randomRemoteImage(action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: .unique, type: .image(.randomRemote), action: action, modifiers: modifiers)
    }
    static func unsplash(_ q: String?, count c: Int? = nil) -> Uicorn.View {
        .init(id: .unique, type: .collection(.unsplash(q, count: c)), action: nil, modifiers: nil)
    }
    static var unsplash: Uicorn.View {
        .unsplash(nil)
    }
    static var database: Uicorn.View {
        .init(id: .unique, type: .collection(.database), action: nil, modifiers: nil)
    }
    static var rectangle: Uicorn.View {
        .rectangle(.system(.yellow))
    }
    static func rectangle(_ c: Uicorn.Color, action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: .unique, type: .shape(.rectangle(c)), action: action, modifiers: modifiers)
    }
    static func ellipse(_ c: Uicorn.Color, action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: .unique, type: .shape(.ellipse(c)), action: action, modifiers: modifiers)
    }
    static func capsule(_ c: Uicorn.Color, action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: .unique, type: .shape(.capsule(c)), action: action, modifiers: modifiers)
    }
    static var map: Uicorn.View {
        .map(location: .eiffelTower)
    }
    static func map(id: String = .unique, location: Uicorn.Location) -> Uicorn.View {
        .init(id: .unique, type: .map(.init(location)), action: nil, modifiers: nil)
    }
    static func hscroll(_ c: [Uicorn.View]) -> Uicorn.View {
        .init(id: .unique, type: .scroll(.init(axis: .horizontal, children: c)), action: nil, modifiers: nil)
    }
    static func vscroll(_ c: [Uicorn.View]) -> Uicorn.View {
        .init(id: .unique, type: .scroll(.init(axis: .vertical, children: c)), action: nil, modifiers: nil)
    }
    static var hscroll: Uicorn.View {
        .hscroll([])
    }
    static var vscroll: Uicorn.View {
        .vscroll([])
    }
    static func instance(_ id: String, values: Uicorn.View.Instance.Values) -> Uicorn.View {
        .init(id: .unique, type: .instance(.init(id: .unique, componentId: id, values: values)), action: nil, modifiers: nil)
    }
    static func postInstance(values: Uicorn.View.Instance.Values) -> Uicorn.View {
        .instance(.postComponentId, values: values)
    }
    static var postInstance: Uicorn.View {
        .postInstance(values: [:])
    }
    static var color: Uicorn.View {
        .color(.random)
    }
    static func color(id: String = .unique, _ c: Uicorn.Color, action: Action? = nil, modifiers: Modifiers? = nil) -> Uicorn.View {
        .init(id: .unique, type: .color(c), action: action, modifiers: modifiers)
    }
}

extension Uicorn.View.Collection {
    static func unsplash(_ q: String?, count c: Int? = nil) -> Uicorn.View.Collection {
        .init(type: .unsplash, parameters: ["query":q, "count":c.map { .init($0) }], view: .image("{{url}}", action: .presentSelf))
    }
    static var database: Uicorn.View.Collection {
        .init(type: .database, parameters: [:], view: nil)
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

extension Uicorn.View.Map {
    static var mock: Uicorn.View.Map {
        .init(.eiffelTower)
    }
    convenience init(_ l: Uicorn.Location) {
        self.init(annotations: [l])
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

extension Uicorn.View.Modifier {
    convenience init(_ id: String = .unique, type: `Type`) {
        self.init(id: id, type: type)
    }
    static func frame(_ f: Uicorn.Frame) -> Uicorn.View.Modifier {
        .init(type: .frame(f))
    }
    static func padding(_ p: Uicorn.Padding) -> Uicorn.View.Modifier {
        .init(type: .padding(p))
    }
    static func background(_ v: Uicorn.View) -> Uicorn.View.Modifier {
        .init(type: .background(v))
    }
    static func cornerRadius(_ c: Int) -> Uicorn.View.Modifier {
        .init(type: .cornerRadius(c))
    }
    static func opacity(_ o: Double) -> Uicorn.View.Modifier {
        .init(type: .opacity(o))
    }
    static func padding(_ v: Int) -> Uicorn.View.Modifier {
        .init(type: .padding(.all(v)))
    }
    static func size(_ v: Int) -> Uicorn.View.Modifier {
        .init(type: .frame(.init(width: .init(v), height: .init(v), alignment: .center)))
    }
    static func width(_ v: Int) -> Uicorn.View.Modifier {
        .init(type: .frame(.init(width: .init(v), height: nil, alignment: .center)))
    }
    static func height(_ v: Int) -> Uicorn.View.Modifier {
        .init(type: .frame(.init(width: nil, height: .init(v), alignment: .center)))
    }
}

extension Array where Element == Uicorn.View.Modifier {
    static var empty: Self {
        .init()
    }
}
