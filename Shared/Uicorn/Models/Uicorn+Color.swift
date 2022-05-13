//
//  Uicorn+Color.swift
//  Code
//
//  Created by Henk van der Spek on 13/05/2022.
//

import Foundation

extension Uicorn.View {
    class Color: Codable {
        enum ColorType: Codable {
            case system(System)
            case custom(Custom)
        }
        let colorType: ColorType
        init(_ t: ColorType) {
            colorType = t
        }
    }
}

extension Uicorn.View.Color {
    enum System: String, Codable {
        case red
        case orange
        case yellow
        case green
        case mint
        case teal
        case cyan
        case blue
        case indigo
        case purple
        case pink
        case brown
        case gray
        case gray2
        case gray3
        case gray4
        case gray5
        case gray6
        case label
        case secondaryLabel
        case quaternaryLabel
        case placeholderText
        case separator
        case opaqueSeparator
        case link
        case background
    }
    struct Custom: Codable {
        let red: UInt8
        let green: UInt8
        let blue: UInt8
        let alpha: Float
    }
}

extension Uicorn.View.Color {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colorType.string, forKey: .colorType)
        try colorType.encodable?.encode(to: encoder)
    }
}

private extension Uicorn.View.Color {
    enum CodingKeys: String, CodingKey {
        case colorType
    }
    enum SimpleColorType: String, Decodable {
        case system
        case custom
    }
}

private extension Uicorn.View.Color.SimpleColorType {
    func complexType(using decoder: Decoder) throws -> Uicorn.View.Color.ColorType {
        switch self {
        case .system: return .system(try .init(from: decoder))
        case .custom: return .custom(try .init(from: decoder))
        }
    }
}

private extension Uicorn.View.Color.ColorType {
    var string: String {
        switch self {
        case .system: return "system"
        case .custom: return "custom"
        }
    }
    var encodable: Encodable? {
        switch self {
        case let .system(s): return s
        case let .custom(c): return c
        }
    }
}

extension Uicorn.View.Color {
    static func system(_ s: Uicorn.View.Color.System) -> Uicorn.View.Color {
        return .init(.system(s))
    }
}

extension Uicorn.View.Color: UicornViewType {}
