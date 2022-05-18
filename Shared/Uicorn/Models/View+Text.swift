//
//  Text.swift
//  Uicorn
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn.View {
    class Text: Codable {
        var value: String
        var font: Uicorn.Font
        init(_ v: String, font f: Uicorn.Font) {
            value = v
            font = f
        }
    }
}

extension Uicorn.View.Text: UicornViewType {}
