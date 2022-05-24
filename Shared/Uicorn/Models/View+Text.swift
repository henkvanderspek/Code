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
        var alignment: Uicorn.TextAlignment
        var textCase: Uicorn.TextCase
        init(_ v: String, font f: Uicorn.Font, alignment a: Uicorn.TextAlignment = .leading, c: Uicorn.TextCase = .standard) {
            value = v
            font = f
            alignment = a
            textCase = c
        }
    }
}

extension Uicorn.View.Text: UicornViewType {}
