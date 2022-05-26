//
//  Frame.swift
//  Code
//
//  Created by Henk van der Spek on 26/05/2022.
//

import Foundation

extension Uicorn {
    class Frame: Codable {
        var width: Float?
        var height: Float?
        var alignment: Alignment
        init(width w: Float?, height h: Float?, alignment a: Alignment) {
            width = w
            height = h
            alignment = a
        }
    }
}

extension Uicorn.Frame {
    static var `default`: Uicorn.Frame {
        .init(width: nil, height: nil, alignment: .center)
    }
}
