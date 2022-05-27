//
//  Color.swift
//  Code
//
//  Created by Henk van der Spek on 13/05/2022.
//

import Foundation

extension Uicorn {
    class Color: Codable {
        enum `Type`: Codable {
            case system(value: System)
            case custom(value: Custom)
        }
        var type: `Type`
        init(_ t: `Type`) {
            type = t
        }
    }
}

extension Uicorn.Color.`Type` {
    static func system(_ v: Uicorn.Color.System) -> Self {
        .system(value: v)
    }
    static func custom(_ v: Uicorn.Color.Custom) -> Self {
        .custom(value: v)
    }
}

extension Uicorn.Color {
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
        case primary
        case secondary
    }
    struct Custom: Codable {
        let red: UInt8
        let green: UInt8
        let blue: UInt8
        let alpha: Float
    }
}

extension Uicorn.Color {
    static func system(_ s: Uicorn.Color.System) -> Uicorn.Color {
        return .init(.system(s))
    }
}
