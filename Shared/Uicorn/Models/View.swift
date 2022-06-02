//
//  View.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn {
    class View: Base, Codable {
        enum `Type`: Codable {
            case hstack(HStack)
            case vstack(VStack)
            case zstack(ZStack)
            case text(Text)
            case image(Image)
            case collection(Collection)
            case shape(Shape)
            case scroll(Scroll)
            case map(Map)
            case instance(Instance)
            case color(Uicorn.Color)
            case spacer
            case empty
        }
        class Modifier: Codable {
            enum `Type`: Codable {
                case frame(Uicorn.Frame)
                case cornerRadius(Int)
                case padding(Uicorn.Padding)
                case background(Uicorn.View)
                case opacity(Double)
                case overlay(Uicorn.View)
                case blendMode(Uicorn.BlendMode)
            }
            var id: String
            var type: `Type`
            init(id i: String, type t: `Type`) {
                id = i
                type = t
            }
        }
        var id: String
        var type: `Type`
        var action: Action?
        var properties: Properties?
        var modifiers: [Modifier]?
        init(id i: String, type t: `Type`, action a: Action?, properties p: Properties?, modifiers m: [Modifier]?) {
            id = i
            type = t
            action = a
            properties = p
            modifiers = m
        }
    }
}

extension Uicorn.View: Identifiable {}
extension Uicorn.View.Modifier: Identifiable {}

protocol UicornViewType {}

extension Uicorn.View: RandomAccessCollection {
    private var subviews: [Uicorn.View] {
        switch type {
        case let .zstack(s):
            return s.children
        case let .hstack(s):
            return s.children
        case let .vstack(s):
            return s.children
        case let .scroll(s):
            return s.children
        case .empty, .collection, .image, .map, .spacer, .shape, .text, .instance, .color:
            return []
        }
    }
    var startIndex: Int {
        subviews.startIndex
    }
    var endIndex: Int {
        subviews.endIndex
    }
    func formIndex(after i: inout Int) {
        subviews.formIndex(after: &i)
    }
    func formIndex(before i: inout Int) {
        subviews.formIndex(before: &i)
    }
    subscript(index: Int) -> Uicorn.View {
        subviews[index]
    }
}
