//
//  ImageScale+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

extension Image.Scale {
    init(_ a: Uicorn.ImageScale) {
        switch a {
        case .small: self = .small
        case .medium: self = .medium
        case .large: self = .large
        }
    }
}
