//
//  JsonUI.View.Type+Codable.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import Foundation

extension JsonUI.View {
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case padding
    }
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        type = try c.decode(ViewType.self, forKey: .type).complexType(using: decoder)
        padding = try c.decodeIfPresent(Padding.self, forKey: .padding)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type.string, forKey: .type)
        try type.encodable?.encode(to: encoder)
        try container.encode(padding, forKey: .padding)
    }
}

private enum ViewType: String, Decodable {
    case hstack
    case vstack
    case zstack
    case image
    case text
    case script
    case empty
}

private extension ViewType {
    func complexType(using decoder: Decoder) throws -> JsonUI.View.`Type` {
        switch self {
        case .hstack: return .hstack(try .init(from: decoder))
        case .vstack: return .vstack(try .init(from: decoder))
        case .zstack: return .zstack(try .init(from: decoder))
        case .image: return .image(try .init(from: decoder))
        case .text: return .text(try .init(from: decoder))
        case .script: return .script(try .init(from: decoder))
        case .empty: return .empty
        }
    }
}

private extension JsonUI.View.`Type` {
    var string: String {
        switch self {
        case .hstack: return "hstack"
        case .vstack: return "vstack"
        case .zstack: return "zstack"
        case .image: return "image"
        case .text: return "text"
        case .script: return "script"
        case .empty: return "empty"
        }
    }
    var encodable: Encodable? {
        switch self {
        case let .hstack(s): return s
        case let .vstack(s): return s
        case let .zstack(s): return s
        case let .image(s): return s
        case let .text(s): return s
        case let .script(s): return s
        case .empty: return nil
        }
    }
}
