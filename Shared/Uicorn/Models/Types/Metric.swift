//
//  Metric.swift
//  Code
//
//  Created by Henk van der Spek on 13/06/2022.
//

import Foundation

extension Uicorn {
    class Metric: Codable {
        enum `Type`: Codable {
            case absolute
            case relative
        }
        var value: Float
        var type: `Type`
        init(value v: Float, type t: `Type`) {
            value = v
            type = t
        }
    }
}

extension Uicorn.Metric {
    convenience init(_ v: Int) {
        self.init(value: .init(v), type: .absolute)
    }
}
