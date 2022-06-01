//
//  TextCase+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

extension Text.Case {
    init?(_ a: Uicorn.TextCase) {
        switch a {
        case .standard: return nil
        case .uppercase: self = .uppercase
        case .lowercase: self = .lowercase
        }
    }
}
