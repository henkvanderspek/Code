//
//  Shape.swift
//  Uicorn
//
//  Created by Henk van der Spek on 13/05/2022.
//

import Foundation

extension Uicorn.View {
    class Shape: Codable {
        enum `Type`: String, Codable, CaseIterable {
            case rectangle
            case roundedRectangle
            case ellipse
            case capsule
        }
        typealias Parameters = [ParameterType: String?]
        enum RoundedCornerStyle: String {
            case circular
            case continuous
        }
        enum ParameterType: String, Codable {
            case cornerRadius
            case roundedCornerStyle
        }
        var type: `Type`
        var fill: Uicorn.Color
        var parameters: Parameters
        init(type t: `Type`, fill f: Uicorn.Color, parameters p: Parameters = [:]) {
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
    var cornerRadius: Int? {
        get {
            parameters[.cornerRadius]?.map { .init($0) } ?? nil
        }
        set {
            parameters[.cornerRadius] = newValue.map { .init($0) }
        }
    }
    var roundedCornerStyle: RoundedCornerStyle? {
        get {
            parameters[.roundedCornerStyle]?.map { .init(rawValue: $0) } ?? nil
        }
        set {
            parameters[.roundedCornerStyle] = newValue.map { $0.rawValue }
        }
    }
}

extension Uicorn.View.Shape.`Type` {
    var localizedTitle: String {
        switch self {
        case .rectangle: return "Rectangle"
        case .roundedRectangle: return "Rounded Rectangle"
        case .ellipse: return "Ellipse"
        case .capsule: return "Capsule"
        }
    }
}
