//
//  AppItem.swift
//  macOS
//
//  Created by Henk van der Spek on 07/05/2022.
//

import SwiftUI

struct AppItem {
    enum `Type` {
        case app(JsonUI.App)
        case screen(JsonUI.Screen)
        case view(JsonUI.View)
    }
    var type: `Type`
    var screen: JsonUI.Screen?
    var view: JsonUI.View?
    var id: String {
        switch type {
        case let .app(a): return a.id
        case let .screen(s): return s.id
        case let .view(v): return v.id
        }
    }
    var children: [AppItem]? {
        switch type {
        case let .app(a):
            return a.screens.map { .init(type: .screen($0), screen: $0, view: nil) }
        case let .screen(s):
            return [.init(type: .view(s.view), screen: s, view: nil)]
        case var .view(v):
            return v.children?.map { .init(type: .view($0), screen: screen, view: $0) }
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
