//
//  Axis+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

extension Axis.Set {
    init(_ a: Uicorn.Axis) {
        switch a {
        case .horizontal: self = .horizontal
        case .vertical: self = .vertical
        }
    }
}
