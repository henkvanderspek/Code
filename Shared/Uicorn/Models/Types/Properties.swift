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
        var backgroundColor: Color?
        var opacity: Double?
        var frame: Frame?
        init(padding p: Padding = .zero, cornerRadius r: Int = 0, backgroundColor b: Color? = nil, opacity o: Double? = nil, frame f: Frame? = nil) {
            padding = p
            cornerRadius = r
            backgroundColor = b
            frame = f
        }
    }
}

extension Uicorn.Properties {
    static func padding(_ p: Uicorn.Padding) -> Uicorn.Properties {
        .init(padding: p)
    }
    static func backgroundColor(_ b: Uicorn.Color) -> Uicorn.Properties {
        .init(backgroundColor: b)
    }
    static func frame(_ f: Uicorn.Frame) -> Uicorn.Properties {
        .init(frame: f)
    }
    static var empty: Uicorn.Properties {
        .init()
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
