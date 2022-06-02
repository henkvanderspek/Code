//
//  View+ZStack.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn.View {
    class ZStack: Codable {
        var children: [Uicorn.View]
        var alignment: Uicorn.Alignment
        init(_ c: [Uicorn.View], alignment a: Uicorn.Alignment = .center) {
            children = c
            alignment = a
        }
    }
}

extension Uicorn.View.ZStack: Bindable {}
