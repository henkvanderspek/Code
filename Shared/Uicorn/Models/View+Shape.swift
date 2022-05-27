//
//  View+Shape.swift
//  Code
//
//  Created by Henk van der Spek on 13/05/2022.
//

import Foundation

extension Uicorn.View {
    class Shape: Codable {
        enum `Type`: String, Codable, CaseIterable {
            case rectangle
            case ellipse
            case capsule
            case circle
        }
        typealias Parameters = [ParameterType: String?]
        enum ParameterType: String, Codable {
            case `none`
        }
        var type: `Type`
        var fill: Uicorn.Color?
        var parameters: Parameters
        init(type t: `Type`, fill f: Uicorn.Color?, parameters p: Parameters = [:]) {
            type = t
            fill = f
            parameters = p
        }
    }
}

extension Uicorn.View.Shape: UicornViewType {}

extension Uicorn.View.Shape {
    static var allTypeCases: [`Type`] {
        `Type`.allCases
    }
}

extension Uicorn.View.Shape.`Type` {
    var localizedTitle: String {
        switch self {
        case .rectangle: return "Rectangle"
        case .ellipse: return "Ellipse"
        case .capsule: return "Capsule"
        case .circle: return "Circle"
        }
    }
}
