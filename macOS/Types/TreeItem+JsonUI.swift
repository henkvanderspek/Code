//
//  TreeItem+JsonUI.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import Foundation

extension JsonUI.App: TreeItem {
    var systemImage: String {
        return "iphone.homebutton"
    }
    var children: [TreeItem]? {
        return screens
    }
}

extension JsonUI.Screen: TreeItem {
    var systemImage: String {
        return "rectangle.portrait"
    }
    var children: [TreeItem]? {
        return [view]
    }
}

extension JsonUI.View {
    var name: String {
        ViewType(from: type).name
    }
}

extension JsonUI.View: TreeItem {
    var systemImage: String {
        ViewType(from: type).systemImage
    }
    var title: String {
        return name
    }
    var children: [TreeItem]? {
        get {
            switch type {
            case let .hstack(s):
                return s.children
            case let .vstack(s):
                return s.children
            case let .zstack(s):
                return s.children
            case .empty, .rectangle, .spacer, .script, .image, .text, .map:
                return nil
            }
        }
        set {
            let children = newValue?.compactMap { $0 as? Self } ?? []
            switch type {
            case .hstack:
                type = .hstack(.init(children: children))
            case .vstack:
                type = .vstack(.init(children: children))
            case .zstack:
                type = .zstack(.init(children: children))
            case .empty, .rectangle, .spacer, .script, .image, .text, .map:
                ()
            }
        }
    }
}
