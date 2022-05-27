//
//  View.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn {
    class View: Codable {
        enum `Type`: Codable {
            case hstack(value: HStack)
            case vstack(value: VStack)
            case zstack(value: ZStack)
            case text(value: Text)
            case image(value: Image)
            case collection(value: Collection)
            case shape(value: Shape)
            case scroll(value: Scroll)
            case map(value: Map)
            case spacer
            case empty
        }
        var id: String
        var type: `Type`
        var action: Action?
        var properties: Properties?
        init(id: String, type: `Type`, action: Action?, properties: Properties?) {
            self.id = id
            self.type = type
            self.action = action
            self.properties = properties
        }
    }
}

extension Uicorn.View.`Type` {
    static func hstack(_ v: Uicorn.View.HStack) -> Self {
        .hstack(value: v)
    }
    static func vstack(_ v: Uicorn.View.VStack) -> Self {
        .vstack(value: v)
    }
    static func zstack(_ v: Uicorn.View.ZStack) -> Self {
        .zstack(value: v)
    }
    static func text(_ v: Uicorn.View.Text) -> Self {
        .text(value: v)
    }
    static func image(_ v: Uicorn.View.Image) -> Self {
        .image(value: v)
    }
    static func collection(_ v: Uicorn.View.Collection) -> Self {
        .collection(value: v)
    }
    static func shape(_ v: Uicorn.View.Shape) -> Self {
        .shape(value: v)
    }
    static func scroll(_ v: Uicorn.View.Scroll) -> Self {
        .scroll(value: v)
    }
    static func map(_ v: Uicorn.View.Map) -> Self {
        .map(value: v)
    }
}

extension Uicorn.View: Identifiable {}

protocol UicornViewType {}

extension Uicorn.View: RandomAccessCollection {
    private var subviews: [Uicorn.View] {
        switch type {
        case let .zstack(s):
            return s.children
        case let .hstack(s):
            return s.children
        case let .vstack(s):
            return s.children
        case let .scroll(s):
            return s.children
        case .empty, .collection, .image, .map, .spacer, .shape, .text:
            return []
        }
    }
    var startIndex: Int {
        subviews.startIndex
    }
    var endIndex: Int {
        subviews.endIndex
    }
    func formIndex(after i: inout Int) {
        subviews.formIndex(after: &i)
    }
    func formIndex(before i: inout Int) {
        subviews.formIndex(before: &i)
    }
    subscript(index: Int) -> Uicorn.View {
        subviews[index]
    }
}
