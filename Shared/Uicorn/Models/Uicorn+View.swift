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
            case vstack(VStack)
            case zstack(ZStack)
            case text(Text)
            case image(Image)
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
    static func hstack(_ c: [Uicorn.View], spacing: Int = 0) -> Uicorn.View {
        .init(id: .unique, type: .hstack(.init(c, spacing: spacing)))
    }
    static func vstack(_ c: [Uicorn.View], spacing: Int = 0) -> Uicorn.View {
        .init(id: .unique, type: .vstack(.init(c, spacing: spacing)))
    }
    static func zstack(_ c: [Uicorn.View]) -> Uicorn.View {
        .init(id: .unique, type: .zstack(.init(c)))
    }
    static func image(_ s: String) -> Uicorn.View {
        .init(id: .unique, type: .image(.init(type: .remote, value: s)))
    }
    static var mock: Uicorn.View {
        .vstack([
            .hstack([
                .image(.random),
                .image(.random),
                .image(.random),
                .image(.random)
            ]),
            .hstack([
                .image(.random),
                .image(.random),
                .image(.random),
                .image(.random)
            ]),
            .hstack([
                .image(.random),
                .image(.random),
                .image(.random),
                .image(.random)
            ]),
            .hstack([
                .image(.random),
                .image(.random),
                .image(.random),
                .image(.random)
            ]),
            .hstack([
                .image(.random),
                .image(.random),
                .image(.random),
                .image(.random)
            ])
        ])
    }
}

private extension String {
    static var allImages: [Self] {
        return [
            "https://images.unsplash.com/photo-1575425186775-b8de9a427e67?auto=format&fit=crop&w=687&q=80",
            "https://images.unsplash.com/photo-1523626797181-8c5ae80d40c2?auto=format&fit=crop&w=500&q=60",
            "https://images.unsplash.com/photo-1517849845537-4d257902454a?auto=format&fit=crop&w=500&q=60",
            "https://images.unsplash.com/photo-1541364983171-a8ba01e95cfc?auto=format&fit=crop&w=500&q=60",
            "https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?auto=format&fit=crop&w=500&q=60",
            "https://images.unsplash.com/photo-1523626752472-b55a628f1acc?auto=format&fit=crop&w=500&q=60"
        ]
    }
    static var random: Self {
        return allImages.randomElement()!
    }
}

private extension Uicorn.View {
    enum ViewType: String, Decodable {
        case hstack
        case vstack
        case zstack
        case text
        case image
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
        case .vstack: return "vstack"
        case .zstack: return "zstack"
        case .text: return "text"
        case .image: return "image"
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
        case .spacer: return nil
        case .empty: return nil
        }
    }
}
