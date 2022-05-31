//
//  View+Instance.swift
//  Code
//
//  Created by Henk van der Spek on 30/05/2022.
//

import Foundation

extension Uicorn.View {
    class Instance: Codable {
        enum Value: Codable {
            case string(value: String)
            case int(value: Int)
        }
        typealias Values = [String:Value]
        var id: String
        var componentId: String
        var values: [String:Value]
        init(id i: String, componentId cid: String, values v: Values) {
            id = i
            componentId = cid
            values = v
        }
    }
}

extension Uicorn.View.Instance {
    func string(for key: String) -> String {
        values[key]?.string ?? .init()
    }
    func int(for key: String) -> Int {
        values[key]?.int ?? .init()
    }
}

extension Uicorn.View.Instance.Value {
    static func string(_ v: String) -> Uicorn.View.Instance.Value {
        .string(value: v)
    }
    static func int(_ v: Int) -> Uicorn.View.Instance.Value {
        .int(value: v)
    }
    var string: String? {
        switch self {
        case let .string(s):
            return s
        case .int:
            return nil
        }
    }
    var int: Int? {
        switch self {
        case let .int(i):
            return i
        case .string:
            return nil
        }
    }
}

extension Uicorn.View.Instance: UicornViewType {}
