//
//  View+Map.swift
//  Code
//
//  Created by Henk van der Spek on 26/05/2022.
//

import Foundation

extension Uicorn.View {
    class Map: Codable {
        var location: Uicorn.Location
        init(location l: Uicorn.Location) {
            location = l
        }
    }
}

extension Uicorn.View.Map: Bindable {}
