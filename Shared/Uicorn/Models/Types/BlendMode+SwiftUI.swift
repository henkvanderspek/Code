//
//  BlendMode+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 03/06/2022.
//

import SwiftUI

extension BlendMode {
    init(_ b: Uicorn.BlendMode) {
        switch b {
        case .normal: self = .normal
        case .multiply: self = .multiply
        case .screen: self = .screen
        case .overlay: self = .overlay
        case .darken: self = .darken
        case .lighten: self = .lighten
        case .colorDodge: self = .colorDodge
        case .colorBurn: self = .colorBurn
        case .softLight: self = .softLight
        case .hardLight: self = .hardLight
        case .difference: self = .difference
        case .exclusion: self = .exclusion
        case .hue: self = .hue
        case .saturation: self = .saturation
        case .color: self = .color
        case .luminosity: self = .luminosity
        case .sourceAtop: self = .sourceAtop
        case .destinationOver: self = .destinationOver
        case .destinationOut: self = .destinationOut
        case .plusDarker: self = .plusDarker
        case .plusLighter: self = .plusLighter
        }
    }
}
