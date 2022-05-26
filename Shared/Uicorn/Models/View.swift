//
//  View.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn {
    class View: Codable {
        enum `Type` {
            case hstack(HStack)
            case vstack(VStack)
            case zstack(ZStack)
            case text(Text)
            case image(Image)
            case collection(Collection)
            case shape(Shape)
            case spacer
            case empty
            case scroll(Scroll)
            case map(Map)
        }
        var id: String
        var type: `Type`
        var action: Action?
        var properties: Properties?
        init(id: String, type: `Type`, action: Action?, properties: Properties?) {
            self.id = id
            self.type = type
            self.action = action
            self.properties = properties
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
        case shape
        case map
        case scroll
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
        case .shape: return .shape(try .init(from: decoder))
        case .map: return .map(try .init(from: decoder))
        case .scroll: return .scroll(try .init(from: decoder))
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
        case .shape: return "shape"
        case .spacer: return "spacer"
        case .map: return "map"
        case .scroll: return "scroll"
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
        case let .shape(s): return s
        case .spacer: return nil
        case .map: return nil
        case let .scroll(s): return s
        case .empty: return nil
        }
    }
}

protocol UicornViewType {}

extension Uicorn.View: RandomAccessCollection {
    private var subviews: [Uicorn.View] {
        switch type {
        case let .zstack(s):
            return s.children
        case let .hstack(s):
            return s.children
        case let .vstack(s):
            return s.children
        case let .scroll(s):
            return s.children
        case .empty, .collection, .image, .map, .spacer, .shape, .text:
            return []
        }
    }
    var startIndex: Int {
        subviews.startIndex
    }
    var endIndex: Int {
        subviews.endIndex
    }
    func formIndex(after i: inout Int) {
        subviews.formIndex(after: &i)
    }
    func formIndex(before i: inout Int) {
        subviews.formIndex(before: &i)
    }
    subscript(index: Int) -> Uicorn.View {
        subviews[index]
    }
}
