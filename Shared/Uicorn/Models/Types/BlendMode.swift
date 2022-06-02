//
//  BlendMode.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import Foundation

extension Uicorn {
    enum BlendMode: String, Codable, CaseIterable {
        case normal
        case multiply
        case screen
        case overlay
        case darken
        case lighten
        case colorDodge
        case colorBurn
        case softLight
        case hardLight
        case difference
        case exclusion
        case hue
        case saturation
        case color
        case luminosity
        case sourceAtop
        case destinationOver
        case destinationOut
        case plusDarker
        case plusLighter
    }
}

extension Uicorn.BlendMode {
    var localizedString: String {
        switch self {
        case .normal: return "Normal"
        case .multiply: return "Multiply"
        case .screen: return "Screen"
        case .overlay: return "Overlay"
        case .darken: return "Darken"
        case .lighten: return "Lighten"
        case .colorDodge: return "Color Dodge"
        case .colorBurn: return "Color Burn"
        case .softLight: return "Soft Light"
        case .hardLight: return "Hard Light"
        case .difference: return "Difference"
        case .exclusion: return "Exclusion"
        case .hue: return "Hue"
        case .saturation: return "Saturation"
        case .color: return "Color"
        case .luminosity: return "Luminosity"
        case .sourceAtop: return "Source Atop"
        case .destinationOver: return "Destination Over"
        case .destinationOut: return "Destination Out"
        case .plusDarker: return "Plus Darker"
        case .plusLighter: return "Plus Lighter"
        }
    }
}
