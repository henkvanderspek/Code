//
//  JsonUI.View.Type+Codable.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import XMLCoder

extension JsonUI.View: Equatable {
    static func == (lhs: JsonUI.View, rhs: JsonUI.View) -> Bool {
        switch (lhs.type, rhs.type) {
        case (.hstack, .hstack): return true
        case (.vstack, .vstack): return true
        case (.zstack, .zstack): return true
        case (.image, .image): return true
        case (.text, .text): return true
        case (.script, .script): return true
        case (.rectangle, .rectangle): return true
        case (.spacer, .spacer): return true
        case (.empty, .empty): return true
        default: return false
        }
    }
}

extension JsonUI.View.Attributes {
    private enum CodingKeys: CodingKey {
        case padding
        case foregroundColor
        case backgroundColor
    }
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        let v = Int(try c.decodeIfPresent(String.self, forKey: .padding) ?? "")
        padding = .init(leading: v, trailing: v, top: v, bottom: v)
        foregroundColor = try c.decodeIfPresent(Color.self, forKey: .foregroundColor)
        backgroundColor = try c.decodeIfPresent(Color.self, forKey: .backgroundColor)
    }
    func encode(to encoder: Encoder) throws {
        // TODO: implement Attributes encoder
    }
}

private extension JsonUI.View {
    struct Empty: Codable {}
    
    struct T: Codable {
        let attributes: Attributes
        let value: String
        init(from decoder: Decoder) throws {
            attributes = try Attributes(from: decoder)
            var c = try decoder.unkeyedContainer()
            value = try c.decode(String.self)
        }
    }

    struct Stack: Codable {
        let attributes: Attributes
        let children: [JsonUI.View]
        init(from decoder: Decoder) throws {
            attributes = try Attributes(from: decoder)
            let c2 = try decoder.singleValueContainer()
            children = try c2.decode([JsonUI.View].self)
        }
    }
    
    enum CodingKeys: String, XMLChoiceCodingKey {
        case padding
        case hstack
        case vstack
        case zstack
        case image
        case text
        case script
        case rectangle
        case spacer
        case empty
    }
}

extension JsonUI.View {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(attributes.padding, forKey: .padding)
        switch type {
        case let .hstack(value):
            try container.encode(value, forKey: .hstack)
        case let .vstack(value):
            try container.encode(value, forKey: .vstack)
        case let .zstack(value):
            try container.encode(value, forKey: .zstack)
        case let .image(value):
            try container.encode(value, forKey: .image)
        case let .text(value):
            try container.encode(value, forKey: .text)
        case let .script(value):
            try container.encode(value, forKey: .script)
        case .rectangle:
            try container.encode(Empty(), forKey: .rectangle)
        case .spacer:
            try container.encode(Empty(), forKey: .spacer)
        case .empty:
            try container.encode(Empty(), forKey: .empty)
        }
    }

    init(from decoder: Decoder) throws {
        self = try Self.decode(from: decoder)
    }
}

private extension JsonUI.View {
    private static func hstack(_ s: Stack) -> Self {
        .hstack(s.children, attributes: s.attributes)
    }
    private static func vstack(_ s: Stack) -> Self {
        .vstack(s.children, attributes: s.attributes)
    }
    private static func zstack(_ s: Stack) -> Self {
        .zstack(s.children, attributes: s.attributes)
    }
    private static func text(_ t: T) -> Self {
        .text(t.value, attributes: t.attributes)
    }
    static func decode(from decoder: Decoder) throws -> Self {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        do {
            if let s = try c.decodeIfPresent(Stack.self, forKey: .hstack) {
                return .hstack(s)
            } else if let s = try c.decodeIfPresent(Stack.self, forKey: .vstack) {
                return .vstack(s)
            } else if let s = try c.decodeIfPresent(Stack.self, forKey: .zstack) {
                return .zstack(s)
            } else if let t = try c.decodeIfPresent(T.self, forKey: .text) {
                return .text(t)
            } else if let _ = try c.decodeIfPresent(Empty.self, forKey: .spacer) {
                return .spacer
            } else if let _ = try c.decodeIfPresent(Empty.self, forKey: .rectangle) {
                return .rectangle // TODO: Padding
            } else { // TODO: image, script
                return .empty
            }
        } catch {
            return .empty
        }
    }
}

extension JsonUI.View.Attributes.Color {
    init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        let s = try c.decode(String.self)
        print(s)
        // TODO: Covert string to native color
        value = .red
    }
    func encode(to encoder: Encoder) throws {
        // TODO: implement SystemColor encoder
    }
}
