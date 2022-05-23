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
        return screens
    }
}

extension Uicorn.Screen: TreeItem {
    var systemImage: String {
        return "rectangle.portrait"
    }
    var children: [TreeItem]? {
        return [view]
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
        switch type {
        case let .hstack(v):
            return v.children
        case let .vstack(v):
            return v.children
        case let .zstack(v):
            return v.children
        case let .collection(c):
            return c.view.map { [$0] }
        case .text, .spacer, .empty, .image, .shape:
            return nil
        }
    }
    var isView: Bool {
        return true
    }
    var canAddView: Bool {
        switch type {
        case .hstack, .vstack, .zstack:
            return true
        case let .collection(c):
            return c.view == nil
        case .text, .spacer, .empty, .image, .shape:
            return false
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
        case .spacer: self = .spacer
        case .empty: self = .empty
        }
    }
}
