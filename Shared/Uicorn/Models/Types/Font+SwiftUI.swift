//
//  Font+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

extension Font {
    init(_ f: Uicorn.Font) {
        self = .system(.init(f.type), design: .init(f.design))
            .weight(.init(f.weight))
            .leading(.init(f.leading))
    }
}

extension Font.TextStyle {
    init(_ t: Uicorn.Font.`Type`) {
        switch t {
        case .body: self = .body
        case .callout: self = .callout
        case .caption: self = .caption
        case .caption2: self = .caption2
        case .footnote: self = .footnote
        case .headline: self = .headline
        case .subheadline: self = .subheadline
        case .largeTitle: self = .largeTitle
        case .title: self = .title
        case .title2: self = .title2
        case .title3: self = .title3
        }
    }
}

extension Font.Weight {
    init(_ w: Uicorn.Font.Weight) {
        switch w {
        case .regular: self = .regular
        case .ultraLight: self = .ultraLight
        case .thin: self = .thin
        case .light: self = .light
        case .medium: self = .medium
        case .semibold: self = .semibold
        case .bold: self = .bold
        case .heavy: self = .heavy
        case .black: self = .black
        }
    }
}

extension Font.Design {
    init(_ d: Uicorn.Font.Design) {
        switch d {
        case .default: self = .default
        case .monospaced: self = .monospaced
        case .rounded: self = .rounded
        case .serif: self = .serif
        }
    }
}

extension Font.Leading {
    init(_ d: Uicorn.Font.Leading) {
        switch d {
        case .standard: self = .standard
        case .loose: self = .loose
        case .tight: self = .tight
        }
    }
}
