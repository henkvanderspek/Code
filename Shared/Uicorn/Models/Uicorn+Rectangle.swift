//
//  Uicorn+Rectangle.swift
//  Code
//
//  Created by Henk van der Spek on 13/05/2022.
//

import Foundation

extension Uicorn.View {
    class Rectangle: Codable {
        let fill: Uicorn.View.Color
        init(fill f: Uicorn.View.Color) {
            fill = f
        }
    }
}

extension Uicorn.View.Rectangle: UicornViewType {}
