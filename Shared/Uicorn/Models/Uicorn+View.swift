//
//  Uicorn+View.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn {
    class View: Codable {
        enum `Type` {
            case hstack(HStack)
            case text(Text)
            case spacer
            case empty
        }
        var id: String
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

extension Uicorn.View: Identifiable {}

extension Uicorn.View {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type.string, forKey: .type)
        try type.encodable?.encode(to: encoder)
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

private extension Uicorn.View {
    enum ViewType: String, Decodable {
        case hstack
        case text
        case spacer
        case empty
    }
}

private extension Uicorn.View.ViewType {
    func complexType(using decoder: Decoder) throws -> Uicorn.View.`Type` {
        switch self {
        case .hstack: return .hstack(try .init(from: decoder))
        case .text: return .text(try .init(from: decoder))
        case .spacer: return .spacer
        case .empty: return .empty
        }
    }
}

private extension Uicorn.View {
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case attributes
    }
}

private extension Uicorn.View.`Type` {
    var string: String {
        switch self {
        case .hstack: return "hstack"
        case .text: return "text"
        case .spacer: return "spacer"
        case .empty: return "empty"
        }
    }
    var encodable: Encodable? {
        switch self {
        case let .hstack(s): return s
        case let .text(t): return t
        case .spacer: return nil
        case .empty: return nil
        }
    }
}
