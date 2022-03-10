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

extension JsonUI.View.Text {
    init(from decoder: Decoder) throws {
        var c = try decoder.unkeyedContainer()
        value = try c.decode(String.self)
        print(value)
    }
}

extension JsonUI.View {
    
    private struct Empty: Codable {}
    
    private struct Stack: Codable {
        private enum CodingKeys: CodingKey {
            case padding
        }
        let padding: Padding?
        let children: [JsonUI.View]
        init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            let c2 = try decoder.singleValueContainer()
            let v = Int(try c.decodeIfPresent(String.self, forKey: .padding) ?? "")
            padding = .init(leading: v, trailing: v, top: v, bottom: v)
            children = try c2.decode([JsonUI.View].self)
        }
    }
    
    private enum CodingKeys: String, XMLChoiceCodingKey {
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(padding, forKey: .padding)
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
        .init(type: .hstack(s.children), padding: s.padding)
    }
    private static func vstack(_ s: Stack) -> Self {
        .init(type: .vstack(s.children), padding: s.padding)
    }
    private static func zstack(_ s: Stack) -> Self {
        .init(type: .zstack(s.children), padding: s.padding)
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
            } else if let s = try c.decodeIfPresent(String.self, forKey: .text) {
                return .text(.init(s)) // TODO: Padding
            } else if let _ = try c.decodeIfPresent(Empty.self, forKey: .spacer) {
                return .spacer
            } else if let _ = try c.decodeIfPresent(Empty.self, forKey: .rectangle) {
                return .rectangle // TODO: Padding
            } else { // TODO image, script
                return .empty
            }
        } catch {
            return .empty
        }
    }
}
