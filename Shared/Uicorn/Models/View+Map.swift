//
//  View+Map.swift
//  Code
//
//  Created by Henk van der Spek on 26/05/2022.
//

import Foundation

extension Uicorn.View {
    class Map: Codable {
        var annotations: [Uicorn.Location]
        init(annotations a: [Uicorn.Location]) {
            annotations = a
        }
    }
}

extension Uicorn.View.Map: Bindable {}
