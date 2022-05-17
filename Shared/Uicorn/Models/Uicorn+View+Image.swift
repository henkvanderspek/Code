//
//  Uicorn+View+Image.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn.View {
    class Image: Codable {
        enum `Type`: String, Codable {
            case remote
            case system
        }
        var type: `Type`
        var value: String
        var fill: Uicorn.Color?
        init(type t: `Type`, value v: String, fill f: Uicorn.Color?) {
            type = t
            value = v
            fill = f
        }
    }
}

extension Uicorn.View.Image: UicornViewType {}
