//
//  ViewType.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

enum ViewType: String, Equatable, CaseIterable {
    case script
    case image
    case vstack
    case hstack
    case zstack
    case spacer
    case text
    case rectangle
    case map
    case collection
    case color
    case empty
}

extension ViewType {
    var name: String {
        switch self {
        case .script: return "Script"
        case .image: return "Image"
        case .vstack: return "VStack"
        case .hstack: return "HStack"
        case .zstack: return "ZStack"
        case .spacer: return "Spacer"
        case .text: return "Text"
        case .rectangle: return "Rectangle"
        case .map: return "Map"
        case .collection: return "Collection"
        case .color: return "Color"
        case .empty: return "Empty"
        }
    }
    var systemImage: String {
        switch self {
        case .script: return "bolt.fill"
        case .image: return "photo"
        case .vstack: return "arrow.up.and.down.square"
        case .hstack: return "arrow.left.and.right.square"
        case .zstack: return "square.stack"
        case .spacer: return "arrow.left.and.right"
        case .text: return "t.square"
        case .rectangle: return "rectangle"
        case .map: return "map"
        case .collection: return "square.grid.3x2"
        case .color: return "drop"
        case .empty: return "rectangle.dashed"
        }
    }
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(name)
    }
}
