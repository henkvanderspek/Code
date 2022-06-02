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

extension Uicorn.HorizontalAlignment {
    init(_ a: Uicorn.VerticalAlignment) {
        switch a {
        case .top: self = .leading
        case .bottom: self = .trailing
        case .center: fallthrough
        default: self = .center
        }
    }
}

extension Uicorn.HorizontalAlignment {
    init(_ a: Uicorn.Alignment) {
        switch a {
        case .topLeading, .top, .topTrailing:
            self = .leading
        case .leading, .center, .trailing:
            self = .center
        case .bottomLeading, .bottom, .bottomTrailing:
            self = .trailing
        }
    }
}
