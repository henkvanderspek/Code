//
//  Uicorn+Collection.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import Foundation

extension Uicorn.View {
    class Collection: Codable {
        typealias Parameters = [String: String?]
        enum `Type`: String, Codable {
            case unsplash
        }
        let type: `Type`
        var parameters: Parameters
        var view: Uicorn.View?
        init(type t: `Type`, parameters p: Parameters, view v: Uicorn.View?) {
            type = t
            parameters = p
            view = v
        }
    }
}

extension Uicorn.View.Collection: UicornViewType {}

extension Uicorn.View.Collection {
    var query: String? {
        get {
            parameters["query"] ?? nil
        }
        set {
            parameters["query"] = newValue
        }
    }
    var count: Int? {
        get {
            parameters["count"]?.map { Int($0) } ?? nil
        }
        set {
            parameters["count"] = newValue.map { String($0) }
        }
    }
}
