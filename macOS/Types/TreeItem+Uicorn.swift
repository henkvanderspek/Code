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
            view = newValue?.compactMap { $0 as? Uicorn.View }.first
        }
    }
    var canAddView: Bool {
        view == nil
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
            switch type {
            case let .hstack(v):
                return v.children
            case let .vstack(v):
                return v.children
            case let .zstack(v):
                return v.children
            case let .collection(c):
                return c.view.map { [$0] }
            case let .scroll(s):
                return s.children
            case .text, .spacer, .empty, .image, .shape, .map, .instance:
                return nil
            }
        }
        set {
            let children = newValue?.compactMap { $0 as? Uicorn.View } ?? []
            switch type {
            case let .hstack(v):
                v.children = children
            case let .vstack(v):
                v.children = children
            case let .zstack(v):
                v.children = children
            case let .collection(c):
                c.view = children.first
            case let .scroll(s):
                s.children = children
            case .text, .spacer, .empty, .image, .shape, .map, .instance:
                fatalError("Can't set children on \(type)")
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
        case .text, .spacer, .empty, .image, .shape, .map, .instance:
            return false
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
        case .empty: self = .empty
        }
    }
}
