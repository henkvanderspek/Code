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
            case text(Text)
            case spacer
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
    class Text: Codable {
        let value: String
        init(_ v: String) {
            value = v
        }
    }
}

private extension Uicorn.View {
    enum ViewType: String, Decodable {
        case hstack
        case text
        case spacer
        case empty
    }
}

extension Uicorn.View.ViewType {
    func complexType(using decoder: Decoder) throws -> Uicorn.View.`Type` {
        switch self {
        case .hstack: return .hstack(try .init(from: decoder))
        case .text: return .text(try .init(from: decoder))
        case .spacer: return .spacer
        case .empty: return .empty
        }
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
    static var spacer: Uicorn.View {
        .init(id: .unique, type: .spacer)
    }
    static func text(_ s: String) -> Uicorn.View {
        .init(id: .unique, type: .text(.init(s)))
    }
    static func hstack(_ c: [Uicorn.View]) -> Uicorn.View {
        .init(id: .unique, type: .hstack(.init(c)))
    }
    static var mock: Uicorn.View {
        .hstack([.spacer, .text("🍖"), .spacer])
    }
}
