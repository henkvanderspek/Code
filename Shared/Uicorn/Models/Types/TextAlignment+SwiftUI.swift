//
//  TextAlignment+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

extension TextAlignment {
    init(_ a: Uicorn.TextAlignment) {
        switch a {
        case .leading: self = .leading
        case .center: self = .center
        case .trailing: self = .trailing
        }
    }
}
