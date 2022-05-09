//
//  Uicorn+Image.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn.View {
    class Image: Codable {
        enum `Type`: String, Codable {
            case remote
        }
        let type: `Type`
        let value: String
        init(type t: `Type`, value v: String) {
            type = t
            value = v
        }
    }
}
