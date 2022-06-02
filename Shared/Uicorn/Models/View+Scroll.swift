//
//  View+Scroll.swift
//  Code
//
//  Created by Henk van der Spek on 26/05/2022.
//

import Foundation

extension Uicorn.View {
    class Scroll: Codable {
        var axis: Uicorn.Axis
        var children: [Uicorn.View]
        init(axis a: Uicorn.Axis, children c: [Uicorn.View]) {
            axis = a
            children = c
        }
    }
}

extension Uicorn.View.Scroll: Bindable {}
