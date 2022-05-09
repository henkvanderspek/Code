//
//  Uicorn+Text.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn.View {
    class Text: Codable {
        let value: String
        init(_ v: String) {
            value = v
        }
    }
}
