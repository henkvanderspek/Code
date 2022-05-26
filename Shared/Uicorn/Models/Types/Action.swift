//
//  Action.swift
//  Code
//
//  Created by Henk van der Spek on 12/05/2022.
//

import Foundation

extension Uicorn.View {
    class Action: Codable {
        enum `Type` {
            case presentSelf
        }
        var actionType: `Type`
        init(actionType t: `Type`) {
            actionType = t
        }
        required init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            actionType = try c.decode(ActionType.self, forKey: .actionType).complexType(using: decoder)
        }
    }
}

extension Uicorn.View.Action {
    fileprivate enum ActionType: String, Decodable {
        case presentSelf
    }
    enum CodingKeys: String, CodingKey {
        case actionType
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(actionType.string, forKey: .actionType)
        try actionType.encodable?.encode(to: encoder)
    }
}

private extension Uicorn.View.Action.`Type` {
    var string: String {
        switch self {
        case .presentSelf: return "presentSelf"
        }
    }
    var encodable: Encodable? {
        switch self {
        case .presentSelf: return nil
        }
    }
}

private extension Uicorn.View.Action.ActionType {
    func complexType(using decoder: Decoder) throws -> Uicorn.View.Action.`Type` {
        switch self {
        case .presentSelf: return .presentSelf
        }
    }
}
