//
//  ColorPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 13/05/2022.
//

import SwiftUI

struct ColorPropertiesView: View {
    let header: String
    @Binding var model: Uicorn.Color
    let showHeader: Bool
    init(header h: String, model m: Binding<Uicorn.Color>, showHeader s: Bool = true) {
        header = h
        _model = m
        showHeader = s
    }
    var body: some View {
        Section {
            if showHeader {
                Header(header)
            }
            Colors(header: header, $model.colorType)
                .pickerStyle(.menu)
        }
        .labelsHidden()
    }
}

private extension ColorPropertiesView.Colors {
    enum Category: String, CaseIterable {
        case system
        case custom
    }
    enum System: String, CaseIterable {
        case red
        case orange
        case yellow
        case green
        case mint
        case teal
        case cyan
        case blue
        case indigo
        case purple
        case pink
        case brown
        case gray
        case gray2
        case gray3
        case gray4
        case gray5
        case gray6
        case label
        case secondaryLabel
        case quaternaryLabel
        case placeholderText
        case separator
        case opaqueSeparator
        case link
        case background
        case fill
        case secondaryFill
    }
}

extension ColorPropertiesView.Colors.System {
    var localizedCapitalized: String {
        switch self {
        case .background, .red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .pink, .brown, .gray, .gray2, .gray3, .gray4, .gray5, .gray6, .label, .separator, .link, .fill:
            return rawValue.localizedCapitalized
        case .secondaryLabel:
            return "Secondary Label"
        case .quaternaryLabel:
            return "Quaternary Label"
        case .placeholderText:
            return "Placeholder Text"
        case .opaqueSeparator:
            return "Opaque Separator"
        case .secondaryFill:
            return "Secondary Fill"
        }
    }
}

private extension ColorPropertiesView {
    struct Colors: View {
        @Binding var colorType: Uicorn.Color.`Type`
        private let header: String
        @State private var category: Category
        @State private var system: System
        @State private var custom: Color
        init(_ t: Binding<Uicorn.Color.`Type`>, _ h: String, _ c: Category, _ s: System = .background, custom cs: Color = .white) {
            _colorType = t
            header = h
            category = c
            system = s
            custom = cs
        }
        var body: some View {
            HStack {
                Picker(header, selection: $category) {
                    ForEach(Category.allCases, id: \.self) {
                        Text($0.rawValue.localizedCapitalized)
                    }
                }
                .onChange(of: category) {
                    colorType = determineColorType(category: $0)
                }
                switch category {
                case .system:
                    Picker("", selection: $system) {
                        ForEach(System.allCases, id: \.self) {
                            Text($0.localizedCapitalized)
                        }
                    }
                    .onChange(of: system) {
                        colorType = determineColorType(system: $0)
                    }
                case .custom:
                    EmptyView()
                }
            }
            RoundedRectangle(cornerRadius: 5)
                .fill(color)
                .frame(height: 20)
        }
        private var color: SwiftUI.Color {
            switch category {
            case .system:
                return .init(.init(system))
            case .custom:
                return custom
            }
        }
    }
}

private extension ColorPropertiesView.Colors {
    init(header h: String, _ c: Binding<Uicorn.Color.`Type`>) {
        switch c.wrappedValue {
        case let .system(s):
            switch s {
            case .red: self = .init(c, h, .system, .red)
            case .orange: self = .init(c, h, .system, .orange)
            case .yellow: self = .init(c, h, .system, .yellow)
            case .green: self = .init(c, h, .system, .green)
            case .mint: self = .init(c, h, .system, .mint)
            case .teal: self = .init(c, h, .system, .teal)
            case .cyan: self = .init(c, h, .system, .cyan)
            case .blue: self = .init(c, h, .system, .blue)
            case .indigo: self = .init(c, h, .system, .indigo)
            case .purple: self = .init(c, h, .system, .purple)
            case .pink: self = .init(c, h, .system, .pink)
            case .brown: self = .init(c, h, .system, .brown)
            case .gray: self = .init(c, h, .system, .gray)
            case .gray2: self = .init(c, h, .system, .gray2)
            case .gray3: self = .init(c, h, .system, .gray3)
            case .gray4: self = .init(c, h, .system, .gray4)
            case .gray5: self = .init(c, h, .system, .gray5)
            case .gray6: self = .init(c, h, .system, .gray6)
            case .label: self = .init(c, h, .system, .label)
            case .secondaryLabel: self = .init(c, h, .system, .secondaryLabel)
            case .quaternaryLabel: self = .init(c, h, .system, .quaternaryLabel)
            case .placeholderText: self = .init(c, h, .system, .placeholderText)
            case .separator: self = .init(c, h, .system, .separator)
            case .opaqueSeparator: self = .init(c, h, .system, .opaqueSeparator)
            case .link: self = .init(c, h, .system, .link)
            case .background: self = .init(c, h, .system, .background)
            case .primary: self = .init(c, h, .system, .fill)
            case .secondary: self = .init(c, h, .system, .secondaryFill)
            }
        case let .custom(cs):
            self = .init(c, h, .custom, custom: .init(cs))
        }
    }
    private func determineColorType(category: Category) -> Uicorn.Color.`Type` {
        switch category {
        case .system:
            return determineColorType(system: system)
        case .custom:
            return .custom(.init(custom))
        }
    }
    private func determineColorType(system: System) -> Uicorn.Color.`Type` {
        return .system(.init(system))
    }
}

private extension Uicorn.Color.System {
    init(_ c: ColorPropertiesView.Colors.System) {
        switch c {
        case .blue: self = .blue
        case .yellow: self = .yellow
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
        case .gray2: self = .gray2
        case .gray3: self = .gray3
        case .gray4: self = .gray4
        case .gray5: self = .gray5
        case .gray6: self = .gray6
        case .label: self = .label
        case .secondaryLabel: self = .secondaryLabel
        case .quaternaryLabel: self = .quaternaryLabel
        case .placeholderText: self = .placeholderText
        case .separator: self = .separator
        case .opaqueSeparator: self = .opaqueSeparator
        case .link: self = .link
        case .background: self = .background
        case .fill: self = .primary
        case .secondaryFill: self = .secondary
        }
    }
}

struct ColorPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            ColorPropertiesView(header: "Color", model: .constant(.system(.yellow)))
        }
    }
}
