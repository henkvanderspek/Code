//
//  ColorPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 13/05/2022.
//

import SwiftUI

struct ColorPropertiesView: View {
    let header: String
    @Binding var model: Uicorn.View.Color
    @State var type: ColorType = .fill
    @State var fillType: FillColorType = .primary
    @State var systemType: SystemColorType = .yellow
    @State var customColor: Color = .white
    init(header s: String, _ color: Binding<Uicorn.View.Color>) {
        header = s
        _model = color
    }
    var body: some View {
        Section {
            Header(header)
            Picker(header, selection: $type) {
                ForEach(ColorType.allCases, id: \.self) {
                    Text($0.rawValue.localizedCapitalized)
                }
            }
            switch type {
            case .fill:
                Picker("", selection: $fillType) {
                    ForEach(FillColorType.allCases, id: \.self) { name in
                        Text(name.rawValue.localizedCapitalized)
                    }
                }
                RoundedRectangle(cornerRadius: 5)
                    .fill(fillType.color)
                    .frame(minHeight: 20)
            case .system:
                Picker("", selection: $systemType) {
                    ForEach(SystemColorType.allCases, id: \.self) {
                        Text($0.rawValue.localizedCapitalized)
                    }
                }
                RoundedRectangle(cornerRadius: 5)
                    .fill(systemType.color)
                    .frame(minHeight: 20)
            case .custom:
                RoundedRectangle(cornerRadius: 5)
                    .fill(customColor)
                    .frame(minHeight: 20)
            }
        }
        .labelsHidden()
        .pickerStyle(.menu)
    }
}

enum ColorType: String, CaseIterable {
    case fill
    case system
    case custom
}

enum FillColorType: String, CaseIterable {
    case primary
    case secondary
}

enum SystemColorType: String, CaseIterable {
    case blue
    case yellow
}

extension FillColorType {
    var color: Color {
        switch self {
        case .primary: return .primary
        case .secondary: return .secondary
        }
    }
}

extension SystemColorType {
    var color: Color {
        switch self {
        case .blue: return .blue
        case .yellow: return .yellow
        }
    }
}

struct ColorPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPropertiesView(header: "Color", .constant(.system(.yellow)))
    }
}
