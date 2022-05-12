//
//  Uicorn+View.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

protocol UicornViewType {}

extension Uicorn {
    class View: Codable {
        enum `Type` {
            case hstack(HStack)
            case vstack(VStack)
            case zstack(ZStack)
            case text(Text)
            case image(Image)
            case collection(Collection)
            case spacer
            case empty
        }
        var id: String
        var type: `Type`
        var action: Action?
        init(id: String, type: `Type`, action: Action?) {
            self.id = id
            self.type = type
            self.action = action
        }
        required init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            id = try c.decodeIfPresent(String.self, forKey: .id) ?? .unique
            type = try c.decode(ViewType.self, forKey: .type).complexType(using: decoder)
            action = try c.decodeIfPresent(Action.self, forKey: .action)
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

private extension Uicorn.View {
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case attributes
        case action
    }
    enum ViewType: String, Decodable {
        case hstack
        case vstack
        case zstack
        case text
        case image
        case collection
        case spacer
        case empty
    }
}

private extension Uicorn.View.ViewType {
    func complexType(using decoder: Decoder) throws -> Uicorn.View.`Type` {
        switch self {
        case .hstack: return .hstack(try .init(from: decoder))
        case .vstack: return .vstack(try .init(from: decoder))
        case .zstack: return .zstack(try .init(from: decoder))
        case .text: return .text(try .init(from: decoder))
        case .image: return .image(try .init(from: decoder))
        case .collection: return .collection(try .init(from: decoder))
        case .spacer: return .spacer
        case .empty: return .empty
        }
    }
}

private extension Uicorn.View.`Type` {
    var string: String {
        switch self {
        case .hstack: return "hstack"
        case .vstack: return "vstack"
        case .zstack: return "zstack"
        case .text: return "text"
        case .image: return "image"
        case .collection: return "collection"
        case .spacer: return "spacer"
        case .empty: return "empty"
        }
    }
    var encodable: Encodable? {
        switch self {
        case let .hstack(s): return s
        case let .vstack(s): return s
        case let .zstack(s): return s
        case let .text(t): return t
        case let .image(i): return i
        case let .collection(c): return c
        case .spacer: return nil
        case .empty: return nil
        }
    }
}
