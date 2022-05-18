//
//  App.swift
//  Uicorn
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn {
    class App: Codable {
        let id: String
        let title: String
        var screens: [Screen]
        init(id: String, title: String, screens: [Screen]) {
            self.id = id
            self.title = title
            self.screens = screens
        }
    }
}

extension Uicorn.App {
    static var mock: Uicorn.App {
        .init(id: .unique, title: "App", screens: [.mock])
    }
}
