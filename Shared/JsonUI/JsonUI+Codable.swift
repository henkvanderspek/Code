//
//  JsonUI.View.Type+Codable.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import Foundation
import CoreGraphics

extension JsonUI.View: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
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
        let v = try c.decodeIfPresent(Int.self, forKey: .padding) ?? 0
        padding = .init(leading: v, trailing: v, top: v, bottom: v)
        foregroundColor = try c.decodeIfPresent(Color.self, forKey: .foregroundColor)
        backgroundColor = try c.decodeIfPresent(Color.self, forKey: .backgroundColor)
    }
    func encode(to encoder: Encoder) throws {
        // TODO: implement Attributes encoder
    }
}

private extension JsonUI.View {
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case attributes
    }

    enum ViewType: String, Decodable {
        case hstack
        case vstack
        case zstack
        case text
        case spacer
        case rectangle
        case image
        case script
        case empty
    }
}

private extension JsonUI.View.ViewType {
    func complexType(using decoder: Decoder) throws -> JsonUI.View.`Type` {
        switch self {
        case .vstack: return .vstack(try .init(from: decoder))
        case .hstack: return .hstack(try .init(from: decoder))
        case .zstack: return .zstack(try .init(from: decoder))
        case .text: return .text(try .init(from: decoder))
        case .image: return .image(try .init(from: decoder))
        case .script: return .script(try .init(from: decoder))
        case .spacer: return .spacer
        case .rectangle: return .rectangle
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
        case .rectangle: return "rectangle"
        case .map: return "map"
        case .spacer: return "spacer"
        case .empty: return "empty"
        }
    }
    var encodable: Encodable? {
        switch self {
        case .empty, .spacer, .rectangle: return nil
        case let .hstack(s): return s
        case let .vstack(s): return s
        case let .zstack(s): return s
        case let .image(i): return i
        case let .text(t): return t
        case let .script(s): return s
        case let .map(m): return m
        }
    }
}
extension JsonUI.View {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type.string, forKey: .type)
        try type.encodable?.encode(to: encoder)
        try container.encode(attributes, forKey: .attributes)
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decodeIfPresent(String.self, forKey: .id) ?? .unique
        type = try c.decode(ViewType.self, forKey: .type).complexType(using: decoder)
        attributes = try c.decodeIfPresent(Attributes.self, forKey: .attributes) ?? .none
    }
}

extension JsonUI.View.Attributes.Color {
    init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        let s = try c.decode(String.self)
        value = .from(s)
    }
    func encode(to encoder: Encoder) throws {
        // TODO: implement SystemColor encoder
    }
}

extension NativeColor {
    static func from(_ s: String) -> NativeColor {
        switch s { // TODO: Parse others
        case "background": return .background
        case "red": return .systemRed
        case "orange": return .systemOrange
        case "yellow": return .systemYellow
        case "green": return .systemGreen
        case "teal": return .systemTeal
        case "mint": return .systemMint
        case "cyan": return .systemCyan
        case "blue": return .systemBlue
        case "indigo": return .systemIndigo
        case "purple": return .systemPurple
        case "pink": return .systemPink
        case "brown": return .systemBrown
        case "gray": return .systemGray
        // TODO: These only exist on iOS. Add fallback for macOS
//        case "gray2": return .systemGray2
//        case "gray3": return .systemGray3
//        case "gray4": return .systemGray4
//        case "gray5": return .systemGray5
//        case "gray6": return .systemGray6
//        case "label": return .label
//        case "secondaryLabel": return .secondaryLabel
//        case "quaternaryLabel": return .quaternaryLabel
//        case "placeholderText": return .placeholderText
//        case "separator": return .separator
//        case "opaqueSeparator": return .opaqueSeparator
//        case "link": return .link
        default: return .init(hexString: s) ?? .background
        }
    }
}

extension NativeColor {
    static var background: NativeColor {
#if os(macOS)
        return .windowBackgroundColor
#elseif os(iOS)
        return .systemBackground
#endif
    }
}

private extension NativeColor {
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        guard hexString.count > 3 else { return nil }
        let hexString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.currentIndex = .init(utf16Offset: 1, in: hexString)
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
