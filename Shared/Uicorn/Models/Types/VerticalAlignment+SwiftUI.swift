//
//  VerticalAlignment+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

extension VerticalAlignment {
    init(_ a: Uicorn.VerticalAlignment) {
        switch a {
        case .top: self = .top
        case .center: self = .center
        case .bottom: self = .bottom
        case .firstTextBaseline: self = .firstTextBaseline
        case .lastTextBaseline: self = .lastTextBaseline
        }
    }
}
