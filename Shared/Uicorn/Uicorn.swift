//
//  Uicorn.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import Foundation

enum Uicorn {
    class App: Codable {
        let id: String
        let title: String
        var screens: [Screen]
        init(id: String, title: String, screens: [Screen]) {
            self.id = id
            self.title = title
            self.screens = screens
        }
    }
    class Screen: Codable {
        let id: String
        let title: String
        var view: View
        init(id: String, title: String, view: View) {
            self.id = id
            self.title = title
            self.view = view
        }
    }
    class View: Codable {
        enum `Type` {
            case hstack(HStack)
            case empty
        }
        let id: String
        var type: `Type`
        init(id: String, type: `Type`) {
            self.id = id
            self.type = type
        }
        required init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            id = try c.decodeIfPresent(String.self, forKey: .id) ?? .unique
            type = try c.decode(ViewType.self, forKey: .type).complexType(using: decoder)
        }
    }
}

extension Uicorn.View {
    class HStack: Codable {
        let children: [Uicorn.View]
        init(_ c: [Uicorn.View]) {
            children = c
        }
    }
}

extension Uicorn.App: TreeItem {
    var systemImage: String {
        "folder"
    }
    var children: [TreeItem]? {
        return screens
    }
}

extension Uicorn.Screen: TreeItem {
    var systemImage: String {
        "folder"
    }
    var children: [TreeItem]? {
        return [view]
    }
}

extension Uicorn.View: TreeItem {
    var title: String {
        switch type {
        case .empty: return "Empty"
        case .hstack: return "HStack"
        }
    }
    var systemImage: String {
        "folder"
    }
    var children: [TreeItem]? {
        return nil
    }
}

extension Uicorn.App {
    static var mock: Uicorn.App {
        .init(id: .unique, title: "App", screens: [.mock])
    }
}

extension Uicorn.Screen {
    static var mock: Uicorn.Screen {
        .init(id: .unique, title: "Home", view: .mock)
    }
}

extension Uicorn.View {
    static var empty: Uicorn.View {
        .init(id: .unique, type: .empty)
    }
    static var mock: Uicorn.View {
        .init(id: .unique, type: .hstack(.init([.empty])))
    }
}

extension Uicorn.View: Equatable {
    static func == (lhs: Uicorn.View, rhs: Uicorn.View) -> Bool {
        switch (lhs.type, rhs.type) {
        case (.hstack, .hstack): return true
        case (.empty, .empty): return true
        default: return false
        }
    }
}

private extension Uicorn.View {
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case attributes
    }

    enum ViewType: String, Decodable {
        case hstack
        case empty
    }
}

private extension Uicorn.View.ViewType {
    func complexType(using decoder: Decoder) throws -> Uicorn.View.`Type` {
        switch self {
        case .hstack: return .hstack(try .init(from: decoder))
        case .empty: return .empty
        }
    }
}

private extension Uicorn.View.`Type` {
    var string: String {
        switch self {
        case .hstack: return "hstack"
        case .empty: return "empty"
        }
    }
    var encodable: Encodable? {
        switch self {
        case .empty: return nil
        case let .hstack(s): return s
        }
    }
}

extension Uicorn.View {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type.string, forKey: .type)
        try type.encodable?.encode(to: encoder)
    }
}
