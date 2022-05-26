//
//  Properties.swift
//  Code
//
//  Created by Henk van der Spek on 13/05/2022.
//

import Foundation

extension Uicorn {
    class Properties: Codable {
        var padding: Padding
        var cornerRadius: Int
        var backgroundColor: Uicorn.Color?
        var opacity: Double?
        init(padding p: Padding, cornerRadius r: Int, backgroundColor b: Uicorn.Color?, opacity o: Double?) {
            padding = p
            cornerRadius = r
            backgroundColor = b
        }
    }
}

extension Uicorn.Properties {
    static func padding(_ p: Uicorn.Padding) -> Uicorn.Properties {
        .init(padding: p, cornerRadius: 0, backgroundColor: nil, opacity: nil)
    }
    static func backgroundColor(_ b: Uicorn.Color) -> Uicorn.Properties {
        .init(padding: .zero, cornerRadius: 0, backgroundColor: b, opacity: nil)
    }
    static var empty: Uicorn.Properties {
        .init(padding: .zero, cornerRadius: 0, backgroundColor: nil, opacity: nil)
    }
    func padding(_ p: Uicorn.Padding) -> Self {
        let v = self
        v.padding = p
        return v
    }
    func cornerRadius(_ r: Int) -> Self {
        let v = self
        v.cornerRadius = r
        return v
    }
    func backgroundColor(_ c: Uicorn.Color?) -> Self {
        let v = self
        v.backgroundColor = c
        return v
    }
    func opacity(_ o: Double?) -> Self {
        let v = self
        v.opacity = o
        return v
    }
}
