//
//  View+VStack.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn.View {
    class VStack: Codable {
        var children: [Uicorn.View]
        var alignment: Uicorn.HorizontalAlignment
        var spacing: Int
        init(_ c: [Uicorn.View], alignment a: Uicorn.HorizontalAlignment = .center, spacing s: Int) {
            children = c
            alignment = a
            spacing = s
        }
    }
}

extension Uicorn.View.VStack: UicornViewType {}
