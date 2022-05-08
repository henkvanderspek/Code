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
        case .text, .spacer, .empty:
            return nil
        }
    }
}

extension ViewType {
    init(from other: Uicorn.View.`Type`) {
        switch other {
        case .hstack: self = .hstack
        case .text: self = .text
        case .spacer: self = .spacer
        case .empty: self = .empty
        }
    }
}
