//
//  Screen.swift
//  Uicorn
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn {
    class Screen: Codable {
        let id: String
        let title: String
        var view: View?
        init(id: String, title: String, view: View) {
            self.id = id
            self.title = title
            self.view = view
        }
    }
}

extension Uicorn.Screen {
    enum Mock {
        case custom(Uicorn.View)
        case `default`
    }
    static var mock: Uicorn.Screen {
        .mock(.default)
    }
    static func mock(_ m: Mock) -> Uicorn.Screen {
        .init(
            id: .unique,
            title: "Home",
            view: {
                switch m {
                case .default: return .mock
                case let .custom(v): return v
                }
            }()
        )
    }
}

extension Uicorn.Screen: Identifiable {}
