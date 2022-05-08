//
//  JsonUI.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import Foundation

enum JsonUI {
    struct View: Codable {
        enum `Type` {
            case hstack(HStack)
            case vstack(VStack)
            case zstack(ZStack)
            case image(Image)
            case text(Text)
            case script(Script)
            case map(Map)
            case rectangle
            case spacer
            case empty
        }
        struct Attributes: Codable {
            struct Padding: Codable {
                let leading: Int?
                let trailing: Int?
                let top: Int?
                let bottom: Int?
            }
            struct Color: Codable {
                let value: NativeColor
            }
            enum Alignment {
                
            }
            let padding: Padding?
            let foregroundColor: Color?
            let backgroundColor: Color?
        }
        let id: String
        var type: `Type`
        let attributes: Attributes
    }
}

extension JsonUI.View {
    init(uuid: UUID = .init(), type t: `Type`, attributes a: Attributes) {
        id = uuid.uuidString
        type = t
        attributes = a
    }
    struct HStack: Codable {
        let children: [JsonUI.View]
    }
    struct VStack: Codable {
        let children: [JsonUI.View]
    }
    struct ZStack: Codable {
        let children: [JsonUI.View]
    }
    struct Image: Codable {}
    struct Text: Codable {
        let value: String
    }
    struct Script: Codable {
        let source: String
    }
    struct Map: Codable {
        struct Coordinate: Codable {
            let latitude: Double
            let longitude: Double
            let title: String?
        }
        let coordinate: Coordinate
    }
}

extension JsonUI.View.Attributes {
    static var none: Self {
        .init(padding: nil, foregroundColor: nil, backgroundColor: nil)
    }
    static func padding(_ p: Padding) -> Self {
        .init(padding: p, foregroundColor: nil, backgroundColor: nil)
    }
}

extension JsonUI.View {
    static func hstack(_ children:  [JsonUI.View] = [], attributes: Attributes = .none) -> Self {
        .init(type: .hstack(.init(children: children)), attributes: attributes)
    }
    static func vstack(_ children:  [JsonUI.View] = [], attributes: Attributes = .none) -> Self {
        .init(type: .vstack(.init(children: children)), attributes: attributes)
    }
    static func zstack(_ children:  [JsonUI.View] = [], attributes: Attributes = .none) -> Self {
        .init(type: .zstack(.init(children: children)), attributes: attributes)
    }
    static func text(_ s: String = .init(), attributes: Attributes = .none) -> Self {
        .init(type: .text(.init(value: s)), attributes: attributes)
    }
    static var text: Self {
        .text()
    }
    static func script(_ s: Script, attributes: Attributes = .none) -> Self {
        .init(type: .script(s), attributes: attributes)
    }
    static func rectangle(_ a: Attributes = .none) -> Self {
        .init(type: .rectangle, attributes: a)
    }
    static var rectangle: Self {
        .rectangle()
    }
    static var spacer: Self {
        .init(type: .spacer, attributes: .none)
    }
    static var empty: Self {
        .init(type: .empty, attributes: .none)
    }
}

extension JsonUI {
    struct Screen: Codable {
        let id: String
        let title: String
        var view: JsonUI.View
    }
    struct App: Codable {
        let id: String
        let title: String
        var screens: [Screen]
    }
}

extension JsonUI.Screen {
    static var mock: Self {
        .init(id: .unique, title: "Home", view: .empty)
    }
}

extension JsonUI.App {
    static var mock: Self {
        return .init(
            id: .unique,
            title: "My App",
            screens: [.init(id: .unique, title: "Home", view: .mock)]
        )
    }
    static var mock2: Self {
        return .init(
            id: .unique,
            title: "My App",
            screens: [.init(id: .unique, title: "Home", view: .text("Hello, World!"))]
        )
    }
}

extension JsonUI.View {
    static var mock: Self {
        .zstack([
            .rectangle(.foregroundColor(.systemCyan)),
            .vstack([
                .hstack([
                    .text("🤓"),
                    .spacer,
                    .text("👍"),
                ]),
                .spacer,
                .text("❤️"),
                .spacer,
                .hstack([
                    .text("👍"),
                    .spacer,
                    .text("🤓"),
                ])
            ],
            attributes: .padding(.all(8)))
        ])
    }
}

extension JsonUI.View.Attributes {
    static func backgroundColor(_ c: NativeColor) -> Self {
        .init(padding: nil, foregroundColor: nil, backgroundColor: .init(value: c))
    }
    static func foregroundColor(_ c: NativeColor) -> Self {
        .init(padding: nil, foregroundColor: .init(value: c), backgroundColor: nil)
    }
}

extension JsonUI.View.Script {
    static var mock: Self {
        .init(
            source: #"""
                function render() {
                    return zstack([
                        color('cyan'),
                        vstack([
                            hstack([
                                text('🤓'),
                                spacer(),
                                text('👍')
                            ]),
                            spacer(),
                            text('❤️'),
                            spacer(),
                            hstack([
                                text('👍'),
                                spacer(),
                                text('🤓')
                            ]),
                        ], {
                            padding: 16
                        })
                    ])
                }
            """#
        )
    }
}

extension JsonUI.View.Map {
    static var mock: Self {
        .init(coordinate: .mock)
    }
}

extension JsonUI.View.Map.Coordinate {
    static var mock: Self {
        .init(
            latitude: 52.3783119,
            longitude: 4.8939736,
            title: "MakeSense"
        )
    }
}

extension JsonUI.Screen: Equatable {}
