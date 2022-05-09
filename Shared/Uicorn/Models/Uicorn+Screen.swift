//
//  Uicorn+Screen.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn {
    class Screen: Codable {
        let id: String
        let title: String
        var view: View
        init(id: String, title: String, view: View) {
            self.id = id
            self.title = title
            self.view = view
        }
    }
}

extension Uicorn.Screen {
    static var mock: Uicorn.Screen {
        .init(id: .unique, title: "Home", view: .mock)
    }
}

extension Uicorn.Screen: Identifiable {}
