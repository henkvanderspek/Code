//
//  AppItem.swift
//  macOS
//
//  Created by Henk van der Spek on 07/05/2022.
//

import SwiftUI

class AppItem: ObservableObject {
    
    enum `Type` {
        case app(JsonUI.App)
        case screen(JsonUI.Screen)
        case view(JsonUI.View)
    }
    
    var type: `Type`
    var screen: JsonUI.Screen?
    
    var view: JsonUI.View? {
        get {
            switch type {
            case let .view(v):
                return v
            case .app, .screen:
                return nil
            }
        }
        set {
            type = newValue.map { .view($0) } ?? type
        }
    }
    
    var children: [AppItem]?
    
    init(type t: `Type`, screen s: JsonUI.Screen? = nil) {
        type = t
        screen = s
        children = {
            switch type {
            case let .app(a):
                return a.screens.map { .init(type: .screen($0)) }
            case let .screen(s):
                return [.init(type: .view(s.view), screen: s)]
            case let .view(v):
                return v.children?.map { .init(type: .view($0), screen: screen) }
            }
        }()
    }
    
    var id: String {
        switch type {
        case let .app(a): return a.id
        case let .screen(s): return s.id
        case let .view(v): return v.id
        }
    }
    
    var title: String {
        switch type {
        case let .app(a):
            return a.title
        case let .screen(s):
            return s.title
        case let .view(v):
            return v.name
        }
    }
    
    var systemImage: String {
        switch type {
        case .app:
            return "iphone.homebutton"
        case .screen:
            return "rectangle.portrait"
        case let .view(v):
            return v.systemImage
        }
    }
}

extension AppItem: Identifiable {}

extension JsonUI.View {
    var systemImage: String {
        ViewType(from: type).systemImage
    }
    var name: String {
        ViewType(from: type).name
    }
}

enum ViewType: String, Equatable, CaseIterable {
    case script
    case image
    case vstack
    case hstack
    case zstack
    case spacer
    case text
    case rectangle
    case map
    case empty
}

private extension ViewType {
    init(from other: JsonUI.View.`Type`) {
        switch other {
        case .script: self = .script
        case .image: self = .image
        case .vstack: self = .vstack
        case .hstack: self = .hstack
        case .zstack: self = .zstack
        case .spacer: self = .spacer
        case .text: self = .text
        case .rectangle: self = .rectangle
        case .map: self = .map
        case .empty: self = .empty
        }
    }
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(name)
    }
}

extension ViewType {
    var name: String {
        switch self {
        case .script: return "Script"
        case .image: return "Image"
        case .vstack: return "VStack"
        case .hstack: return "HStack"
        case .zstack: return "ZStack"
        case .spacer: return "Spacer"
        case .text: return "Text"
        case .rectangle: return "Rectangle"
        case .map: return "map"
        case .empty: return "Empty"
        }
    }
    var systemImage: String {
        switch self {
        case .script: return "bolt.fill"
        case .image: return "photo"
        case .vstack: return "arrow.up.and.down.square"
        case .hstack: return "arrow.left.and.right.square"
        case .zstack: return "square.stack"
        case .spacer: return "arrow.left.and.right"
        case .text: return "t.square"
        case .rectangle: return "rectangle"
        case .map: return "map"
        case .empty: return "rectangle.dashed"
        }
    }
}

extension JsonUI.App {
    var appItem: AppItem {
        .init(type: .app(self))
    }
}

extension AppItem: Equatable {
    static func == (lhs: AppItem, rhs: AppItem) -> Bool {
        lhs.id == rhs.id && lhs.type == rhs.type
    }
}

extension AppItem.`Type`: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.app, .app): return true
        case (.screen, .screen): return true
        case let (.view(lhv), .view(rhv)): return lhv == rhv
        default: return false
        }
    }
}
