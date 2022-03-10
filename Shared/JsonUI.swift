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
        var id = UUID()
        let type: `Type`
        let padding: Padding?
    }
}

extension JsonUI.View {
    struct Image: Codable {}
    struct Text: Codable {
        let value: String
    }
    struct Padding: Codable {
        let leading: Int?
        let trailing: Int?
        let top: Int?
        let bottom: Int?
    }
    struct Script: Codable {
        let source: String
    }
}

extension JsonUI.View {
    static func hstack(_ children:  [JsonUI.View] = [], padding: Padding? = nil) -> Self {
        .init(type: .hstack(children), padding: padding)
    }
    static func vstack(_ children:  [JsonUI.View] = [], padding: Padding? = nil) -> Self {
        .init(type: .vstack(children), padding: padding)
    }
    static func zstack(_ children:  [JsonUI.View] = [], padding: Padding? = nil) -> Self {
        .init(type: .zstack(children), padding: padding)
    }
    static func text(_ s: String = .init(), padding: Padding? = nil) -> Self {
        .init(type: .text(.init(value: s)), padding: padding)
    }
    static var text: Self {
        .text()
    }
    static func script(_ s: Script, padding: Padding? = nil) -> Self {
        .init(type: .script(s), padding: padding)
    }
    static var rectangle: Self {
        .init(type: .rectangle, padding: nil)
    }
    static var spacer: Self {
        .init(type: .spacer, padding: nil)
    }
    static var empty: Self {
        .init(type: .empty, padding: nil)
    }
}

extension JsonUI.View.Script {
    static var mock: Self {
        .init(
            source: #"""
                function render() {
                    return `<zstack>
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
