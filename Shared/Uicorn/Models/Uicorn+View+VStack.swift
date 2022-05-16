//
//  Uicorn+View+VStack.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn.View {
    class VStack: Codable {
        var children: [Uicorn.View]
        var spacing: Int
        init(_ c: [Uicorn.View], spacing s: Int) {
            children = c
            spacing = s
        }
    }
}

extension Uicorn.View.VStack: UicornViewType {}
