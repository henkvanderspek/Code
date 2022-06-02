//
//  Frame.swift
//  Code
//
//  Created by Henk van der Spek on 26/05/2022.
//

import SwiftUI

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

extension Uicorn.Frame {
    var w: CGFloat? {
        let v = width.map { CGFloat($0) }
        return v ?? 0 > 0 ? v : nil
    }
    var h: CGFloat? {
        let v = height.map { CGFloat($0) }
        return v ?? 0 > 0 ? v : nil
    }
    var a: Alignment {
        .init(alignment)
    }
}
