//
//  Action.swift
//  Code
//
//  Created by Henk van der Spek on 12/05/2022.
//

import Foundation

extension Uicorn.View {
    class Action: Codable {
        enum `Type`: Codable {
            case presentSelf
        }
        var type: `Type`
        init(type t: `Type`) {
            type = t
        }
    }
}
