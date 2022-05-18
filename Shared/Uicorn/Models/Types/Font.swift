//
//  Font.swift
//  Uicorn
//
//  Created by Henk van der Spek on 17/05/2022.
//

import Foundation

extension Uicorn {
    class Font: Codable {
        enum `Type`: String, Codable, CaseIterable {
            case body
            case callout
            case caption
            case caption2
            case footnote
            case headline
            case subheadline
            case largeTitle
            case title
            case title2
            case title3
        }
        enum Weight: String, Codable, CaseIterable {
            case ultraLight
            case thin
            case light
            case regular
            case medium
            case semibold
            case bold
            case heavy
            case black
        }
        var type: `Type`
        var weight: Weight
        init(_ t: `Type`, weight w: Weight) {
            type = t
            weight = w
        }
    }
}

extension Uicorn.Font {
    static var `default`: Uicorn.Font {
        .init(.body, weight: .regular)
    }
    static var allTypeCases: [Uicorn.Font.`Type`] {
        `Type`.allCases
    }
    static var allWeightCases: [Uicorn.Font.Weight] {
        Weight.allCases
    }
}

extension Uicorn.Font.`Type` {
    var localizedString: String {
        switch self {
        case .callout: return "Callout"
        case .caption: return "Caption"
        case .caption2: return "Caption 2"
        case .footnote: return "Caption 3"
        case .headline: return "Headline"
        case .subheadline: return "Subheadline"
        case .largeTitle: return "Large title"
        case .title: return "Title"
        case .title2: return "Title 2"
        case .title3: return "Title 3"
        case .body: fallthrough
        @unknown default: return "Body"
        }
    }
}

extension Uicorn.Font.Weight {
    var localizedString: String {
        switch self {
        case .ultraLight: return "Ultra Light"
        case .thin: return "Thin"
        case .light: return "Light"
        case .medium: return "Medium"
        case .semibold: return "Semibold"
        case .bold: return "Bold"
        case .heavy: return "Heavy"
        case .black: return "Black"
        case .regular: fallthrough
        default: return "Regular"
        }
    }
}
