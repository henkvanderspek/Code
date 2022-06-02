//
//  ModifiersView.swift
//  macOS
//
//  Created by Henk van der Spek on 02/06/2022.
//

import SwiftUI

struct ModifiersView: View {
    @Binding var modifiers: Uicorn.View.Modifiers
    init(_ m: Binding<Uicorn.View.Modifiers>) {
        _modifiers = m
    }
    var body: some View {
        Section {
            ForEach($modifiers) { $modifier in
                switch modifier.type {
                case .opacity:
                    OptionalPropertiesView(header: modifier.title, value: $modifier.opacity, defaultValue: 1.0) { value in
                        HGroup {
                            StepperView($modifier.opacity, default: 1.0, range: 0...1, step: 0.1, header: "Opacity", showHeader: false)
                            GreedySpacer()
                        }
                    }
                case .padding, .blendMode, .cornerRadius, .frame, .overlay, .background:
                    OptionalPropertiesView(header: modifier.title, value: .constant(nil), defaultValue: 1) { _ in
                        Text(modifier.title)
                    }
                }
                Divider()
            }
//            ForEach(ViewModifier.allCases, id: \.self) { m in
//                OptionalPropertiesView(header: m.localizedString, value: .constant(nil), defaultValue: 1) { _ in
//                    Text(m.localizedString)
//                }
//                Divider()
//            }
        }
        .labelsHidden()
    }
}

private extension Uicorn.View.Modifier {
    var opacity: Double? {
        get {
            switch type {
            case let .opacity(o): return o
            default: return nil
            }
        }
        set {
            type = .opacity(newValue ?? 1.0)
            id = .unique
            print(type)
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

extension ViewModifier {
    init(_ t: Uicorn.View.Modifier.`Type`) {
        switch t {
        case .opacity: self = .opacity
        case .frame: self = .frame
        case .cornerRadius: self = .cornerRadius
        case .padding: self = .padding
        case .background: self = .background
        case .overlay: self = .overlay
        case .blendMode: self = .blendMode
        }
    }
}

extension Uicorn.View.Modifier {
    var title: String {
        ViewModifier(type).localizedString
    }
}
