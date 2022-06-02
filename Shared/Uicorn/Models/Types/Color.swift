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
            case system(System)
            case custom(Custom)
        }
        var type: `Type`
        init(_ t: `Type`) {
            type = t
        }
    }
}

extension Uicorn.Color {
    static var random: Uicorn.Color {
        .system(.random)
    }
    static var clear: Uicorn.Color {
        .custom(.clear)
    }
    static func system(_ s: Uicorn.Color.System) -> Uicorn.Color {
        .init(.system(s))
    }
    static func custom(_ c: Uicorn.Color.Custom) -> Uicorn.Color {
        .init(.custom(c))
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

extension FixedWidthInteger {
    static var random: Self {
        random(in: min...max)
    }
}

extension Uicorn.Color.Custom {
    static var random: Uicorn.Color.Custom {
        .init(
            red: .random,
            green: .random,
            blue: .random,
            alpha: 1.0
        )
    }
    static var clear: Uicorn.Color.Custom {
        .init(.clear)
    }
}

extension Uicorn.Color.System {
    static var random: Uicorn.Color.System {
        return [
            .yellow,
            .blue,
            .red,
            .orange,
            .green,
            .mint,
            .teal,
            .cyan,
            .indigo,
            .purple,
            .pink,
            .brown
        ].randomElement()!
    }
}
