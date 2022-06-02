//
//  Alignment.swift
//  Code
//
//  Created by Henk van der Spek on 24/05/2022.
//

import Foundation

extension Uicorn {
    @frozen enum Alignment: String, Codable, CaseIterable {
        case topLeading
        case top
        case topTrailing
        case leading
        case center
        case trailing
        case bottomLeading
        case bottom
        case bottomTrailing
    }
}

extension Uicorn.Alignment {
    var localizedString: String {
        switch self {
        case .topLeading: return "Top Leading"
        case .top: return "Top"
        case .topTrailing: return "Top Trailing"
        case .leading: return "Leading"
        case .center: return "Center"
        case .trailing: return "Trailing"
        case .bottomLeading: return "Bottom Leading"
        case .bottom: return "Bottom"
        case .bottomTrailing: return "Bottom Trailing"
        }
    }
}

extension Uicorn.Alignment {
    init(_ a: Uicorn.VerticalAlignment) {
        switch a {
        case .top: self = .leading
        case .bottom: self = .trailing
        case .center: fallthrough
        default: self = .center
        }
    }
}

extension Uicorn.Alignment {
    init(_ a: Uicorn.HorizontalAlignment) {
        switch a {
        case .leading: self = .leading
        case .trailing: self = .trailing
        case .center: self = .center
        }
    }
}
