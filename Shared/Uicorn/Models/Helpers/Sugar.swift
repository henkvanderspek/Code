//
//  Sugar.swift
//  Uicorn
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
    static func text(_ s: String, font: Uicorn.Font = .default, alignment: Uicorn.TextAlignment = .leading, action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .text(.init(s, font: font, alignment: alignment)), action: action, properties: nil)
    }
    static var helloWorld: Uicorn.View {
        .text("~HI~ *HELLO*\n**WORLD**\n🌎", font: .init(type: .largeTitle, weight: .regular, design: .default), alignment: .center)
    }
    static func hstack(_ c: [Uicorn.View], spacing: Int = 0, padding: Uicorn.Padding? = nil) -> Uicorn.View {
        .init(id: .unique, type: .hstack(.init(c, spacing: spacing)), action: nil, properties: padding.map { .init(padding: $0, cornerRadius: 0) })
    }
    static func vstack(_ c: [Uicorn.View], spacing: Int = 0, padding: Uicorn.Padding? = nil) -> Uicorn.View {
        .init(id: .unique, type: .vstack(.init(c, spacing: spacing)), action: nil, properties: padding.map { .init(padding: $0, cornerRadius: 0) })
    }
    static func zstack(_ c: [Uicorn.View], action: Action? = nil, padding: Uicorn.Padding? = nil) -> Uicorn.View {
        .init(id: .unique, type: .zstack(.init(c)), action: action, properties: padding.map { .init(padding: $0, cornerRadius: 0) })
    }
    static func image(_ s: String, type: Image.`Type`, fill: Uicorn.Color? = nil, action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .image(.init(type: type, value: s, fill: fill)), action: action, properties: nil)
    }
    static var randomSystemImage: Uicorn.View {
        randomSystemImage()
    }
    static func randomSystemImage(fill: Uicorn.Color? = nil, action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .image(.randomSystem(fill: fill)), action: action, properties: nil)
    }
    static var randomRemoteImage: Uicorn.View {
        randomRemoteImage()
    }
    static func randomRemoteImage(fill: Uicorn.Color? = nil, action: Action? = nil) -> Uicorn.View {
        .init(id: .unique, type: .image(.randomRemote(fill: fill)), action: action, properties: nil)
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
