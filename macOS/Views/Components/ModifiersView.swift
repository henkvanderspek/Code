//
//  ModifiersView.swift
//  macOS
//
//  Created by Henk van der Spek on 02/06/2022.
//

import SwiftUI

struct ModifiersView: View {
    @Binding var modifiers: Uicorn.View.Modifiers
    @State var showPopover = false
    init(_ m: Binding<Uicorn.View.Modifiers>) {
        _modifiers = m
    }
    var body: some View {
        Section {
            HGroup {
                Header("Modifiers", fontWeight: .regular).opacity(0.5)
                Spacer()
                Button {
                    showPopover = true
                } label: {
                    Label("Add", systemImage: "plus")
                        .labelStyle(.iconOnly)
                        .frame(width: 10, height: 15)
                }
                .buttonStyle(.borderless)
                .opacity(0.5)
                .popover(isPresented: $showPopover, arrowEdge: .bottom) {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(ViewModifier.sanitizedCases, id: \.self) { m in
                            Button {
                                showPopover = false
                                modifiers.append(.init(m))
                            } label: {
                                Label(m.localizedString, systemImage: "")
                                    .labelStyle(.titleOnly)
                            }
                            .buttonStyle(.link)
                            .padding(2)
                        }
                    }
                    .padding()
                }
            }
            Divider()
            ForEach($modifiers) { $modifier in
                switch modifier.type {
                case .opacity:
                    OptionalPropertiesView(header: modifier.title, value: binding(id: $modifier.id, $modifier.opacity), defaultValue: 1.0) { value in
                        HGroup {
                            StepperView($modifier.opacity, default: 1.0, range: 0...1, step: 0.1, header: "Opacity", showHeader: false)
                            GreedySpacer()
                        }
                    }
                    Divider()
                case .padding:
                    OptionalPropertiesView(header: modifier.title, value: binding(id: $modifier.id, $modifier.padding), defaultValue: .zero) { value in
                        HGroup {
                            PaddingPropertiesView(value, showHeader: false)
                            GreedySpacer()
                        }
                    }
                    Divider()
                case .blendMode, .cornerRadius, .frame, .overlay, .background:
//                    OptionalPropertiesView(header: modifier.title, value: .constant(nil), defaultValue: 1) { _ in
//                        Text(modifier.title)
//                    }
                    EmptyView()
                }
                
            }
        }
        .labelsHidden()
    }
}

private extension ModifiersView {
    func binding<T>(id: String, _ m: Binding<T?>) -> Binding<T?> {
        .init(
            get: {
                m.wrappedValue
            },
            set: { v in
                if v == nil {
                    $modifiers.wrappedValue = modifiers.filter { $0.id != id }
                } else {
                    m.wrappedValue = v
                }
            }
        )
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
        }
    }
    var padding: Uicorn.Padding? {
        get {
            switch type {
            case let .padding(p): return p
            default: return nil
            }
        }
        set {
            type = .padding(newValue ?? .zero)
            id = .unique
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
    static var sanitizedCases: [Self] {
        return [
            .opacity,
            .padding
        ]
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

private extension Uicorn.View.Modifier {
    convenience init(_ v: ViewModifier) {
        switch v {
        case .opacity: self.init(type: .opacity(1))
        case .overlay: self.init(type: .overlay(.empty))
        case .padding: self.init(type: .padding(.zero))
        case .frame: self.init(type: .frame(.default))
        case .blendMode: self.init(type: .blendMode(.normal))
        case .cornerRadius: self.init(type: .cornerRadius(0))
        case .background: self.init(type: .background(.empty))
        }
    }
}

extension Uicorn.View.Modifier {
    var title: String {
        ViewModifier(type).localizedString
    }
}
