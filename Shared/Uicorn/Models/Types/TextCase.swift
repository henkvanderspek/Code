//
//  TextCase.swift
//  Code
//
//  Created by Henk van der Spek on 24/05/2022.
//

import Foundation

extension Uicorn {
    @frozen enum TextCase: String, Codable, CaseIterable {
        case standard
        case uppercase
        case lowercase
    }
}

extension Uicorn.TextCase {
    var localizedString: String {
        switch self {
        case .standard: return "Standard"
        case .uppercase: return "Uppercase"
        case .lowercase: return "Lowercase"
        }
    }
}
