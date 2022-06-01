//
//  Color+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

extension Color {
    init(_ c: Uicorn.Color) {
        switch c.type {
        case let .system(s):
            self = .init(s)
        case let .custom(c):
            self = .init(c)
        }
    }
    init(_ s: Uicorn.Color.System) {
        switch s {
        case .primary: self = .primary
        case .secondary: self = .secondary
        case .yellow: self = .yellow
        case .blue: self = .blue
        case .red: self = .red
        case .orange: self = .orange
        case .green: self = .green
        case .mint: self = .mint
        case .teal: self = .teal
        case .cyan: self = .cyan
        case .indigo: self = .indigo
        case .purple: self = .purple
        case .pink: self = .pink
        case .brown: self = .brown
        case .gray: self = .gray
        case .gray2: self = .init(nativeColor: .systemGray2)
        case .gray3: self = .init(nativeColor: .systemGray3)
        case .gray4: self = .init(nativeColor: .systemGray4)
        case .gray5: self = .init(nativeColor: .systemGray5)
        case .gray6: self = .init(nativeColor: .systemGray6)
        case .label: self = .init(nativeColor: .label)
        case .secondaryLabel: self = .init(nativeColor: .secondaryLabel)
        case .quaternaryLabel: self = .init(nativeColor: .quaternaryLabel)
        case .placeholderText: self = .init(nativeColor: .placeholderText)
        case .separator: self = .init(nativeColor: .separator)
        case .opaqueSeparator: self = .init(nativeColor: .opaqueSeparator)
        case .link: self = .init(nativeColor: .link)
        case .background: self = .init(nativeColor: .systemBackground)
        }
    }
}

extension Uicorn.Color.Custom {
    init(_ c: Color) {
        self = .init(red: 255, green: 255, blue: 255, alpha: 1.0) // TODO:
    }
}

extension Color {
    init(_ c: Uicorn.Color.Custom) {
        self = .white // TODO:
    }
}
