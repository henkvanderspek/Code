//
//  JsonUI.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import Foundation

#if os(macOS)
import AppKit
typealias NativeColor = NSColor
#elseif os(iOS)
import UIKit
typealias NativeColor = UIColor
#endif

enum JsonUI {
    struct View: Codable {
        enum `Type` {
            case hstack([JsonUI.View])
            case vstack([JsonUI.View])
            case zstack([JsonUI.View])
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
        var id = UUID()
        let type: `Type`
        let attributes: Attributes
    }
}

extension JsonUI.View {
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
        .init(type: .hstack(children), attributes: attributes)
    }
    static func vstack(_ children:  [JsonUI.View] = [], attributes: Attributes = .none) -> Self {
        .init(type: .vstack(children), attributes: attributes)
    }
    static func zstack(_ children:  [JsonUI.View] = [], attributes: Attributes = .none) -> Self {
        .init(type: .zstack(children), attributes: attributes)
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
    static var rectangle: Self {
        .init(type: .rectangle, attributes: .none)
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
                    return `<zstack backgroundColor="red">
                        <rectangle/>
                        <vstack padding="16">
                            <hstack>
                                <text>🤓</text>
                                <spacer/>
                                <text>👍</text>
                            </hstack>
                            <spacer/>
                            <text>❤️</text>
                            <spacer/>
                            <hstack>
                                <text>👍</text>
                                <spacer/>
                                <text>🤓</text>
                            </hstack>
                        </vstack>
                    </zstack>`
                }
            """#
        )
    }
}
