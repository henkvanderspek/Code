//
//  Uicorn+HStack.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn.View {
    class HStack: Codable {
        let children: [Uicorn.View]
        init(_ c: [Uicorn.View]) {
            children = c
        }
    }
}
