//
//  TreeItem+Uicorn.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

extension Uicorn.App: TreeItem {
    var systemImage: String {
        return "iphone.homebutton"
    }
    var children: [TreeItem]? {
        get {
            return screens
        }
        set {
            screens = newValue?.compactMap { $0 as? Uicorn.Screen } ?? []
        }
    }
    var view: Uicorn.View? {
        return nil
    }
    var isHidden: Bool {
        get {
            return false
        }
        set {}
    }
}

extension Uicorn.Screen: TreeItem {
    var systemImage: String {
        return "rectangle.portrait"
    }
    var children: [TreeItem]? {
        get {
            view.map { [$0] }
        }
        set {
            view = newValue?.compactMap { $0.view }.first
        }
    }
    var canAddView: Bool {
        view == nil
    }
    var isHidden: Bool {
        get {
            return false
        }
        set {}
    }
}

extension Uicorn.View: TreeItem {
    var systemImage: String {
        ViewType(from: type).systemImage
    }
    var title: String {
        ViewType(from: type).name
    }
    var children: [TreeItem]? {
        get {
            func sanitize(_ c: [Uicorn.View]?) -> [TreeItem]? {
                let ret = (overlays ?? []) + (c ?? []) + (backgrounds ?? [])
                return ret.isEmpty ? nil : ret
            }
            switch type {
            case let .hstack(v):
                return sanitize(v.children)
            case let .vstack(v):
                return sanitize(v.children)
            case let .zstack(v):
                return sanitize(v.children)
            case let .collection(c):
                return sanitize(c.view.map { [$0] })
            case let .scroll(s):
                return sanitize(s.children)
            case .text, .spacer, .empty, .image, .shape, .map, .instance, .color:
                return sanitize(nil)
            }
        }
        set {
            let children = newValue?.filter { $0.isView } ?? []
            // We need to filter the children that are utility views
            let uviews = children.filter { $0.isUtilityView }
            // Clean up the modifiers of type view that are not in this list
            modifiers = modifiers?.filter {
                switch $0.type {
                case let .overlay(v):
                    return uviews.contains(where: { $0.id == v.id })
                case let .background(v):
                    return uviews.contains(where: { $0.id == v.id })
                default:
                    return true
                }
            }
            // Pass all non utility views on to the type to handle
            let views = children.filter { !$0.isUtilityView }.compactMap { $0.view }
            switch type {
            case let .hstack(v):
                v.children = views
            case let .vstack(v):
                v.children = views
            case let .zstack(v):
                v.children = views
            case let .collection(c):
                c.view = views.first
            case let .scroll(s):
                s.children = views
            case .text, .spacer, .empty, .image, .shape, .map, .instance, .color: ()
            }
        }
    }
    var isView: Bool {
        return true
    }
    var isSpacer: Bool {
        type.isSpacer
    }
    var canAddView: Bool {
        switch type {
        case .hstack, .vstack, .zstack, .scroll:
            return true
        case let .collection(c):
            return c.view == nil
        case .text, .spacer, .empty, .image, .shape, .map, .instance, .color:
            return false
        }
    }
    var view: Uicorn.View? {
        return self
    }
    private var overlays: [TreeItem]? {
        modifiers?.compactMap { $0.overlay }.map { Utility($0, .overlay) }
    }
    private var backgrounds: [TreeItem]? {
        modifiers?.compactMap { $0.background }.map { Utility($0, .background) }
    }
}

private extension Uicorn.View {
    class Utility {
        enum `Type` {
            case overlay
            case background
        }
        private var v: Uicorn.View
        private var t: `Type`
        init(_ view: Uicorn.View, _ type: `Type`) {
            v = view
            t = type
        }
    }
}

extension Uicorn.View.Utility: TreeItem {
    var view: Uicorn.View? {
        v
    }
    var id: String {
        v.id
    }
    var title: String {
        "\(ViewType(from: v.type).name) (\(t.title))"
    }
    var systemImage: String {
        v.systemImage
    }
    var isView: Bool {
        v.isView
    }
    var isSpacer: Bool {
        v.isSpacer
    }
    var children: [TreeItem]? {
        get {
            v.children
        }
        set {
            v.children = newValue
        }
    }
    var isSelected: Bool {
        get {
            v.isSelected
        }
        set {
            v.isSelected = newValue
        }
    }
    var isUtilityView: Bool {
        return true
    }
    var canAddView: Bool {
        v.canAddView
    }
    var isHidden: Bool {
        get {
            v.isHidden
        }
        set {
            v.isHidden = newValue
        }
    }
}

private extension Uicorn.View.Utility.`Type` {
    var title: String {
        switch self {
        case .overlay: return "O"
        case .background: return "B"
        }
    }
}

extension Uicorn.View.`Type` {
    var isSpacer: Bool {
        switch self {
        case .spacer: return true
        default: return false
        }
    }
}

extension ViewType {
    init(from other: Uicorn.View.`Type`) {
        switch other {
        case .hstack: self = .hstack
        case .vstack: self = .vstack
        case .zstack: self = .zstack
        case .text: self = .text
        case let .image(i):
            switch i.type {
            case .remote: self = .image
            case .system: self = .sfSymbol
            }
        case .collection: self = .collection
        case .shape: self = .shape
        case .map: self = .map
        case let .scroll(s):
            switch s.axis {
            case .horizontal: self = .hscroll
            case .vertical: self = .vscroll
            }
        case .instance: self = .instance
        case .spacer: self = .spacer
        case .color: self = .color
        case .empty: self = .empty
        }
    }
}
