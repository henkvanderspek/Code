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
            let padding: Padding?
            let foregroundColor: Color?
            let backgroundColor: Color?
        }
        let id: String
        let type: `Type`
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
    static func rectangle(attributes: Attributes = .none) -> Self {
        .init(type: .rectangle, attributes: attributes)
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

extension JsonUI.View.Script {
    static var mock: Self {
        .init(
            source: #"""
                function render() {
                    return {
                        type: 'zstack',
                        children: [
                            {
                                type: 'rectangle',
                                attributes: {
                                    foregroundColor: 'cyan'
                                }
                            },
                            {
                                type: 'vstack',
                                children: [
                                    {
                                        type: 'hstack',
                                        children: [
                                            {
                                                type: 'text',
                                                value: '🤓'
                                            },
                                            {
                                                type: 'spacer'
                                            },
                                            {
                                                type: 'text',
                                                value: '👍'
                                            }
                                        ]
                                    },
                                    {
                                        type: 'spacer'
                                    },
                                    {
                                        type: 'text',
                                        value: '❤️'
                                    },
                                    {
                                        type: 'spacer'
                                    },
                                    {
                                        type: 'hstack',
                                        children: [
                                            {
                                                type: 'text',
                                                value: '👍'
                                            },
                                            {
                                                type: 'spacer'
                                            },
                                            {
                                                type: 'text',
                                                value: '🤓'
                                            }
                                        ]
                                    },
                                ],
                                attributes: {
                                    padding: 16
                                }
                            }
                        ]
                    }
                }
            """#
        )
    }
}
