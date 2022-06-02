//
//  VerticalAlignment.swift
//  Code
//
//  Created by Henk van der Spek on 24/05/2022.
//

import Foundation

extension Uicorn {
    @frozen enum VerticalAlignment: String, Codable, CaseIterable {
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
        case .center: return "Center"
        }
    }
}

extension Uicorn.VerticalAlignment {
    init(_ a: Uicorn.HorizontalAlignment) {
        switch a {
        case .leading: self = .top
        case .center: self = .center
        case .trailing: self = .bottom
        }
    }
}

extension Uicorn.VerticalAlignment {
    init(_ a: Uicorn.Alignment) {
        switch a {
        case .topLeading, .top, .topTrailing:
            self = .top
        case .leading, .center, .trailing:
            self = .center
        case .bottomLeading, .bottom, .bottomTrailing:
            self = .bottom
        }
    }
}
