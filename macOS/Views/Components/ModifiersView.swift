//
//  ModifiersView.swift
//  macOS
//
//  Created by Henk van der Spek on 02/06/2022.
//

import SwiftUI

struct ModifiersView: View {
    @Binding var model: Uicorn.View.Modifiers
    init(_ m: Binding<Uicorn.View.Modifiers>) {
        _model = m
    }
    var body: some View {
        ForEach(ViewModifier.allCases, id: \.self) { m in
            OptionalPropertiesView(header: m.localizedString, value: .constant(nil), defaultValue: 1) { _ in
                Text(m.localizedString)
            }
            Divider()
        }
    }
}

struct ModifiersPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        ModifiersView(.constant([]))
    }
}

private enum ViewModifier: String, CaseIterable {
    case frame
    case padding
    case background
    case cornerRadius
    case blendMode
    case overlay
    case opacity
}

extension ViewModifier {
    var localizedString: String {
        switch self {
        case .opacity: return "Opacity"
        case .frame: return "Frame"
        case .cornerRadius: return "Corner Radius"
        case .padding: return "Padding"
        case .background: return "Background"
        case .overlay: return "Overlay"
        case .blendMode: return "Blend Mode"
        }
    }
}
