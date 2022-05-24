//
//  TextAlignment.swift
//  Code
//
//  Created by Henk van der Spek on 24/05/2022.
//

import Foundation

extension Uicorn {
    enum TextAlignment: String, Codable, CaseIterable {
        case leading
        case center
        case trailing
    }
}

extension Uicorn.TextAlignment {
    var localizedString: String {
        switch self {
        case .leading: return "Leading"
        case .trailing: return "Trailing"
        case .center: fallthrough
        @unknown default: return "Center"
        }
    }
}
