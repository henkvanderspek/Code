//
//  Axis.swift
//  Code
//
//  Created by Henk van der Spek on 26/05/2022.
//

import Foundation

extension Uicorn {
    @frozen enum Axis: String, Codable, CaseIterable {
        case horizontal
        case vertical
    }
}

extension Uicorn.Axis {
    var localizedString: String {
        switch self {
        case .horizontal: return "Horizontal"
        case .vertical: return "Vertical"
        }
    }
}
