//
//  View.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn {
    class View: Base, Codable {
        enum `Type`: Codable {
            case hstack(HStack)
            case vstack(VStack)
            case zstack(ZStack)
            case text(Text)
            case image(Image)
            case collection(Collection)
            case shape(Shape)
            case scroll(Scroll)
            case map(Map)
            case instance(Instance)
            case color(Uicorn.Color)
            case spacer
            case empty
        }
        class Modifier: Codable {
            enum `Type`: Codable {
                case frame(Uicorn.Frame)
                case cornerRadius(Int)
                case padding(Uicorn.Padding)
                case background(Uicorn.View)
                case opacity(Double)
                case overlay(Uicorn.View)
                case blendMode(Uicorn.BlendMode)
            }
            var id: String
            var type: `Type`
            init(id i: String, type t: `Type`) {
                id = i
                type = t
            }
        }
        typealias Modifiers = [Modifier]
        var id: String
        var type: `Type`
        var action: Action?
        var modifiers: Modifiers?
        var isHidden: Bool
        init(id i: String, type t: `Type`, action a: Action?, modifiers m: Modifiers?, isHidden h: Bool = false) {
            id = i
            type = t
            action = a
            modifiers = m
            isHidden = h
        }
    }
}

extension Uicorn.View: Identifiable {}
extension Uicorn.View.Modifier: Identifiable {}

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
        case .empty, .collection, .image, .map, .spacer, .shape, .text, .instance, .color:
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

extension Uicorn.View.`Type`: Bindable {}
extension Uicorn.View.Modifiers: Bindable {}

extension Uicorn.View {
    func embeddedInHStack() {
        modified(type: .hstack(.init([cloned()], alignment: .center, spacing: 0)))
    }
    func embeddedInVStack() {
        modified(type: .vstack(.init([cloned()], alignment: .center, spacing: 0)))
    }
    func embeddedInZStack() {
        modified(type: .zstack(.init([cloned()])))
    }
    func cloned() -> Uicorn.View {
        .init(id: id, type: type, action: action, modifiers: modifiers, isHidden: isHidden)
    }
    func type(_ t: `Type`) -> Uicorn.View {
        let v = cloned()
        v.type = t
        return v
    }
    private func modified(type t: Uicorn.View.`Type`) {
        id = UUID().uuidString
        type = t
        action = nil
        modifiers = nil
    }
    var color: Uicorn.Color? {
        guard case let .color(c) = type else { return nil }
        return c
    }
    var image: Image? {
        guard case let .image(i) = type else { return nil }
        return i
    }
}

extension Uicorn.View.Modifier {
    var opacity: Double? {
        get {
            switch type {
            case let .opacity(o): return o
            default: return nil
            }
        }
        set {
            type = .opacity(newValue ?? 1.0)
        }
    }
    var padding: Uicorn.Padding? {
        get {
            switch type {
            case let .padding(p): return p
            default: return nil
            }
        }
        set {
            type = .padding(newValue ?? .zero)
        }
    }
    var cornerRadius: Int? {
        get {
            switch type {
            case let .cornerRadius(r): return r
            default: return nil
            }
        }
        set {
            type = .cornerRadius(newValue ?? .zero)
        }
    }
    var frame: Uicorn.Frame? {
        get {
            switch type {
            case let .frame(f): return f
            default: return nil
            }
        }
        set {
            type = .frame(newValue ?? .default)
        }
    }
    var blendMode: Uicorn.BlendMode? {
        get {
            switch type {
            case let .blendMode(b): return b
            default: return nil
            }
        }
        set {
            type = .blendMode(newValue ?? .normal)
        }
    }
    var backgroundColor: Uicorn.Color? {
        get {
            switch type {
            case let .background(v): return v.color
            default: return nil
            }
        }
        set {
            type = .background(newValue.map { .color($0) } ?? .empty)
        }
    }
    var overlayImage: Uicorn.View.Image? {
        get {
            switch type {
            case let .overlay(v): return v.image
            default: return nil
            }
        }
        set {
            type = .overlay(newValue.map { .image($0) } ?? .empty)
        }
    }
    var background: Uicorn.View? {
        get {
            switch type {
            case let .background(v): return v
            default: return nil
            }
        }
        set {
            type = .background(newValue ?? .empty)
        }
    }
    var overlay: Uicorn.View? {
        get {
            switch type {
            case let .overlay(v): return v
            default: return nil
            }
        }
        set {
            type = .overlay(newValue ?? .empty)
        }
    }
}
