//
//  VerticalAlignment.swift
//  Code
//
//  Created by Henk van der Spek on 24/05/2022.
//

import Foundation

extension Uicorn {
    enum VerticalAlignment: String, Codable, CaseIterable {
        case top
        case center
        case bottom
        case firstTextBaseline
        case lastTextBaseline
    }
}

extension Uicorn.VerticalAlignment {
    var localizedString: String {
        switch self {
        case .top: return "Top"
        case .bottom: return "Bottom"
        case .firstTextBaseline: return "First Text Baseline"
        case .lastTextBaseline: return "Last Text Baseline"
        case .center: fallthrough
        @unknown default: return "Center"
        }
    }
}
