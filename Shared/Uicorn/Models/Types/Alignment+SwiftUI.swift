//
//  Alignment+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

extension Alignment {
    init(_ a: Uicorn.Alignment) {
        switch a {
        case .topLeading: self = .topLeading
        case .top: self = .top
        case .topTrailing: self = .topTrailing
        case .leading: self = .leading
        case .center: self = .center
        case .trailing: self = .trailing
        case .bottomLeading: self = .bottomLeading
        case .bottom: self = .bottom
        case .bottomTrailing: self = .bottomTrailing
        }
    }
}
