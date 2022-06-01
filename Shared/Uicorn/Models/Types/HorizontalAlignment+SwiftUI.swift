//
//  HorizontalAlignment+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

extension HorizontalAlignment {
    init(_ a: Uicorn.HorizontalAlignment) {
        switch a {
        case .leading: self = .leading
        case .center: self = .center
        case .trailing: self = .trailing
        }
    }
}
