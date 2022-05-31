//
//  Font.swift
//  Code
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
        enum Design: String, Codable, CaseIterable {
            case `default`
            case rounded
            case serif
            case monospaced
        }
        enum Leading: String, Codable, CaseIterable {
            case standard
            case loose
            case tight
        }
        var type: `Type`
        var weight: Weight
        var design: Design
        var leading: Leading
        init(type t: `Type`, weight w: Weight, design d: Design, leading l: Leading) {
            type = t
            weight = w
            design = d
            leading = l
        }
    }
}

extension Uicorn.Font {
    static var `default`: Uicorn.Font {
        .init(type: .body, weight: .regular, design: .default, leading: .standard)
    }
    static var allTypeCases: [Uicorn.Font.`Type`] {
        `Type`.allCases
    }
    func weight(_ w: Weight) -> Uicorn.Font {
        let f = self
        f.weight = w
        return f
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

extension Uicorn.Font.Design {
    var localizedString: String {
        switch self {
        case .`default`: return "Default"
        case .serif: return "Serif"
        case .rounded: return "Rounded"
        case .monospaced: return "Monospaced"
        }
    }
}

extension Uicorn.Font.Leading {
    var localizedString: String {
        switch self {
        case .standard: return "Standard"
        case .loose: return "Loose"
        case .tight: return "Tight"
        }
    }
}
