//
//  ZStack.swift
//  Uicorn
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn.View {
    class ZStack: Codable {
        var children: [Uicorn.View]
        init(_ c: [Uicorn.View]) {
            children = c
        }
    }
}

extension Uicorn.View.ZStack: UicornViewType {}
