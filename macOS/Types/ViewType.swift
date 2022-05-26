//
//  ViewType.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

enum ViewType: String, Equatable, CaseIterable {
    case script
    case sfSymbol
    case image
    case vstack
    case hstack
    case zstack
    case spacer
    case text
    case map
    case collection
    case shape
    case hscroll
    case vscroll
    case empty
}

extension ViewType {
    var name: String {
        switch self {
        case .script: return "Script"
        case .sfSymbol: return "SF Symbol"
        case .image: return "Image"
        case .vstack: return "VStack"
        case .hstack: return "HStack"
        case .zstack: return "ZStack"
        case .spacer: return "Spacer"
        case .text: return "Text"
        case .map: return "Map"
        case .collection: return "Collection"
        case .shape: return "Shape"
        case .hscroll: return "HScroll"
        case .vscroll: return "VScroll"
        case .empty: return "Empty"
        }
    }
    var systemImage: String {
        switch self {
        case .script: return "bolt.fill"
        case .sfSymbol: return "s.circle"
        case .image: return "photo"
        case .vstack: return "arrow.up.and.down.square"
        case .hstack: return "arrow.left.and.right.square"
        case .zstack: return "square.stack"
        case .spacer: return "arrow.left.and.right"
        case .text: return "t.square"
        case .map: return "map"
        case .collection: return "square.grid.3x2"
        case .shape: return "square.on.circle"
        case .hscroll: return "arrow.left.arrow.right"
        case .vscroll: return "arrow.up.arrow.down"
        case .empty: return "rectangle.dashed"
        }
    }
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(name)
    }
    var canAddItem: Bool {
        switch self {
        case .text, .spacer, .sfSymbol, .image, .vstack, .hstack, .zstack, .map, .shape, .collection, .vscroll, .hscroll:
            return true
        case .script, .empty:
            return false
        }
    }
    static var sanitizedCases: [Self] {
        allCases.filter { $0.canAddItem }
    }
}
