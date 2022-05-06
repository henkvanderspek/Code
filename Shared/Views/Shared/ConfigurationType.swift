//
//  ConfigurationType.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

enum ConfigurationType {
    struct Stack {
        enum Axis {
            case horizontal
            case vertical
            case depth
        }
        var axis: Axis
        var spacing: Int?
    }
    enum Event {
        case none
        case tap
    }
    enum Action {
        case none
        case present
        case push
        case alert
        case dismiss
        case open
    }
    struct EventAction {
        var event: Event
        var action: Action
        var referenceId: String?
    }
    enum Value {
        case constant(String)
        case variable(String)
    }
    enum Position {
        case front
        case back
    }
    struct Property {
        enum `Type` {
            case text
            case rectangle
        }
        let name: String
        let value: String
        let type: `Type`
    }
    struct Font {
        var weight: SwiftUI.Font.Weight
        var textStyle: SwiftUI.Font.TextStyle
    }
    struct Rect {
        var leading: Int
        var trailing: Int
        var top: Int
        var bottom: Int
    }
    struct Color {
        var value: SwiftUI.Color
    }
    struct Number {
        var value: Int
        var isRelative: Bool
    }
    struct Size {
        var width: Number?
        var height: Number?
    }
    case stack(Stack)
    case property(Property)
    case color(Color)
    case sfSymbol(Value, Color)
    case image(Value)
    case camera(Position)
    case tapAction(EventAction)
    case text(String)
    case margins(JsonUI.View.Attributes.Padding)
    case font(Font)
    case alignment(JsonUI.View.Attributes.Alignment)
    case spacer
    case coordinate(JsonUI.View.Map.Coordinate)
    case size(Size)
}
