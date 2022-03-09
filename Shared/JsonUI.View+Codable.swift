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
        case (.empty, .empty): return true
        default: return false
        }
    }
}

extension JsonUI.View {
    
    private struct Empty: Codable {}
    
    private enum CodingKeys: String, XMLChoiceCodingKey {
        case hstack
        case vstack
        case zstack
        case image
        case text
        case script
        case spacer
        case empty
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
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
        case .spacer:
            try container.encode(Empty(), forKey: .spacer)
        case .empty:
            try container.encode(Empty(), forKey: .empty)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            // TODO image, script
            if let h: [Self] = try container.parseStack(forKey: .hstack) {
                self = .hstack(h)
            } else if let v: [Self] = try container.parseStack(forKey: .vstack) {
                self = .vstack(v)
            } else if let z: [Self] = try container.parseStack(forKey: .zstack) {
                self = .zstack(z)
            } else if let s = try container.decodeIfPresent(String.self, forKey: .text) {
                self = .text(.init(s))
            } else if let _ = try container.decodeIfPresent(Empty.self, forKey: .spacer) {
                self = .spacer
            } else {
                self = .empty
            }
        } catch {
            self = .empty
        }
    }
}

private extension KeyedDecodingContainer {
    func parseStack<V>(forKey key: Key) throws -> [V]? where V: Decodable {
        guard contains(key) else {
            return nil
        }
        do {
            var stackContainer = try nestedUnkeyedContainer(forKey: key)
            var ret: [V] = []
            do {
                while true {
                    ret.append(try stackContainer.decode(V.self))
                }
            } catch {}
            return ret
        } catch {
            return try decode([V].self, forKey: key)
        }
    }
}
