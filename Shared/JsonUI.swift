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
            case empty
        }
        var id = UUID()
        let type: `Type`
        let padding: Padding?
    }
}

extension JsonUI.View {
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
        .init(type: .hstack(.init(children: children)), padding: padding)
    }
    static func vstack(_ children:  [JsonUI.View] = [], padding: Padding? = nil) -> Self {
        .init(type: .vstack(.init(children: children)), padding: padding)
    }
    static func zstack(_ children:  [JsonUI.View] = [], padding: Padding? = nil) -> Self {
        .init(type: .zstack(.init(children: children)), padding: padding)
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
    static var empty: Self {
        .init(type: .empty, padding: nil)
    }
}

extension JsonUI.View.Script {
    static var mock: Self {
        .init(
            source: #"""
                function render() {
                    return {
                        type: 'text',
                        value: 'Hello World! 🤓👍'
                    }
                }
            """#
        )
    }
}
