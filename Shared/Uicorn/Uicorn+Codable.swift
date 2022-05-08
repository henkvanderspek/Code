//
//  Uicorn+Codable.swift
//  Code
//
//  Created by Henk van der Spek on 08/05/2022.
//

import Foundation

extension Uicorn.View {
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

extension Uicorn.View {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type.string, forKey: .type)
        try type.encodable?.encode(to: encoder)
    }
}
