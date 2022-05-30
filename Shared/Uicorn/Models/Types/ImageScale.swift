//
//  ImageScale.swift
//  Code
//
//  Created by Henk van der Spek on 30/05/2022.
//

import Foundation

extension Uicorn {
    @frozen enum ImageScale: String, Codable, CaseIterable {
        case small
        case medium
        case large
    }
}

extension Uicorn.ImageScale {
    var localizedString: String {
        switch self {
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large"
        }
    }
}
