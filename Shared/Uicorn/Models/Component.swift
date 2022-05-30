//
//  Component.swift
//  Code
//
//  Created by Henk van der Spek on 30/05/2022.
//

import Foundation

extension Uicorn {
    class Component: Base, Codable {
        let id: String
        let title: String
        var view: Uicorn.View
        init(id: String, title: String, view: Uicorn.View) {
            self.id = id
            self.title = title
            self.view = view
        }
    }
}
