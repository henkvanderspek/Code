//
//  HorizontalAlignment.swift
//  Code
//
//  Created by Henk van der Spek on 24/05/2022.
//

import Foundation

extension Uicorn {
    @frozen enum HorizontalAlignment: String, Codable, CaseIterable {
        case leading
        case center
        case trailing
    }
}

extension Uicorn.HorizontalAlignment {
    var localizedString: String {
        switch self {
        case .leading: return "Leading"
        case .trailing: return "Trailing"
        case .center: return "Center"
        }
    }
}