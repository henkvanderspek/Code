//
//  Properties.swift
//  Uicorn
//
//  Created by Henk van der Spek on 13/05/2022.
//

import Foundation

extension Uicorn {
    class Properties: Codable {
        var padding: Padding
        var cornerRadius: Int
        init(padding p: Padding, cornerRadius cr: Int) {
            padding = p
            cornerRadius = cr
        }
    }
}

extension Uicorn.Properties {
    static var empty: Uicorn.Properties {
        .init(padding: .zero, cornerRadius: 0)
    }
    func padding(_ p: Uicorn.Padding) -> Self {
        let v = self
        v.padding = p
        return v
    }
    func cornerRadius(_ c: Int) -> Self {
        let v = self
        v.cornerRadius = c
        return v
    }
}
