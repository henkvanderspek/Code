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
        var title: String
        var view: View
        var parameters: [Parameter]
        init(id i: String, title t: String, view v: View, parameters p: [Parameter]) {
            id = i
            title = t
            view = v
            parameters = p
        }
    }
}

extension Uicorn.Component {
    class Parameter: Codable {
        enum `Type`: Codable {
            case string
            case int
        }
        let id: String
        let viewId: String
        var title: String
        var type: `Type`
        init(id i: String, viewId v: String, title t: String, type ty: `Type`) {
            id = i
            viewId = v
            title = t
            type = ty
        }
    }
}
