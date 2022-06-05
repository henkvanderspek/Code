//
//  View+Collection.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import Foundation

extension Uicorn.View {
    class Collection: Codable {
        typealias Parameters = [String: String?]
        enum `Type`: String, Codable, CaseIterable {
            case unsplash
            case sfSymbols
            case database
        }
        var type: `Type`
        var parameters: Parameters
        var view: Uicorn.View?
        init(type t: `Type`, parameters p: Parameters, view v: Uicorn.View?) {
            type = t
            parameters = p
            view = v
        }
    }
}

extension Uicorn.View.Collection: Bindable {}

extension Uicorn.View.Collection {
    static var allTypeCases: [`Type`] {
        `Type`.allCases
    }
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
    var entity: String? {
        get {
            parameters["entity"] ?? nil
        }
        set {
            parameters["entity"] = newValue
        }
    }
}

extension Uicorn.View.Collection.`Type` {
    var localizedTitle: String {
        switch self {
        case .unsplash: return "Unsplash"
        case .sfSymbols: return "SF Symbols"
        case .database: return "Database"
        }
    }
}
