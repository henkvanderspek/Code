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
        Section {
            ForEach(ViewModifier.allCases, id: \.self) { m in
                switch m {
                case .opacity:
                    OptionalPropertiesView(header: m.localizedString, value: $model.opacity, defaultValue: 1.0) { value in
                        HGroup {
                            StepperView($model.opacity, default: 1.0, range: 0...1, step: 0.1, header: "Opacity")
                            GreedySpacer()
                        }
                    }
                default:
                    OptionalPropertiesView(header: m.localizedString, value: .constant(nil), defaultValue: 1) { _ in
                        Text(m.localizedString)
                    }
                }
                Divider()
            }
        }.labelsHidden()
    }
}

private extension Uicorn.View.Modifiers {
    var opacity: Double? {
        get {
            compactMap {
                switch $0.type {
                case let .opacity(o):
                    return o
                default:
                    return nil
                }
            }.first
        }
        set {
            append(.opacity(newValue!))
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
