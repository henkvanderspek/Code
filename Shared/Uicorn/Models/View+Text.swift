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
        init(_ v: String, font f: Uicorn.Font, alignment a: Uicorn.TextAlignment = .leading) {
            value = v
            font = f
            alignment = a
        }
    }
}

extension Uicorn.View.Text: UicornViewType {}
