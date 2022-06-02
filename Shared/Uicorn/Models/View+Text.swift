//
//  View+Text.swift
//  Code
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
        var foregroundColor: Uicorn.Color?
        init(_ v: String, font f: Uicorn.Font, alignment a: Uicorn.TextAlignment, textCase c: Uicorn.TextCase, foregroundColor fc: Uicorn.Color?) {
            value = v
            font = f
            alignment = a
            textCase = c
            foregroundColor = fc
        }
    }
}

extension Uicorn.View.Text: Bindable {}
