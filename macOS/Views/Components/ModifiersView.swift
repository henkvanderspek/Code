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
                            Slider(value: value, in: 0...1)
                        }
                    }
                case .padding:
                    OptionalPropertiesView(header: modifier.title, value: binding(id: $modifier.id, $modifier.padding), defaultValue: .zero) { value in
                        HGroup {
                            PaddingPropertiesView(value, showHeader: false)
                            GreedySpacer()
                        }
                    }
                case .cornerRadius:
                    OptionalPropertiesView(header: modifier.title, value: binding(id: $modifier.id, $modifier.cornerRadius), defaultValue: 0) { value in
                        HGroup {
                            StepperView(Binding(value), default: 0, range: 0...1000, step: 1, header: "Corner Radius", showHeader: false)
                            GreedySpacer()
                        }
                    }
                case .frame:
                    OptionalPropertiesView(header: modifier.title, value: binding(id: $modifier.id, $modifier.frame), defaultValue: .default) { value in
                        FramePropertiesView(value)
                    }
                case .blendMode:
                    OptionalPropertiesView(header: modifier.title, value: binding(id: $modifier.id, $modifier.blendMode), defaultValue: .normal) { value in
                        HGroup {
                            Picker(modifier.title, selection: value) {
                                ForEach(Uicorn.BlendMode.allCases, id: \.self) {
                                    Text($0.localizedString)
                                }
                            }
                        }
                    }
                case .background:
                    OptionalPropertiesView(header: "Background Color", value: binding(id: $modifier.id, $modifier.backgroundColor), defaultValue: .system(.background)) { value in
                        // TODO: Add picker to select type
                        ColorPropertiesView(header: "Background Color", model: value, showHeader: false)
                        // TODO: Add image and other common types
                    }
                case .overlay:
                    OptionalPropertiesView(header: "Overlay Image", value: binding(id: $modifier.id, $modifier.overlayImage), defaultValue: .randomRemote) { value in
                        // TODO: Add picker to select type
                        ImagePropertiesView(value)
                        // TODO: Add color and other common types
                    }
                }
                Divider()
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
                    modifiers.remove(id: id)
                } else {
                    m.wrappedValue = v
                }
            }
        )
    }
}

private extension Uicorn.View.Modifiers {
    mutating func remove(id: String) {
        guard let i = firstIndex(where: { $0.id == id }) else { return }
        remove(at: i)
        print("Delete modifier")
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
        }
    }
    var cornerRadius: Int? {
        get {
            switch type {
            case let .cornerRadius(r): return r
            default: return nil
            }
        }
        set {
            type = .cornerRadius(newValue ?? .zero)
        }
    }
    var frame: Uicorn.Frame? {
        get {
            switch type {
            case let .frame(f): return f
            default: return nil
            }
        }
        set {
            type = .frame(newValue ?? .default)
        }
    }
    var blendMode: Uicorn.BlendMode? {
        get {
            switch type {
            case let .blendMode(b): return b
            default: return nil
            }
        }
        set {
            type = .blendMode(newValue ?? .normal)
        }
    }
    var backgroundColor: Uicorn.Color? {
        get {
            switch type {
            case let .background(v): return v.color
            default: return nil
            }
        }
        set {
            type = .background(newValue.map { .color($0) } ?? .empty)
        }
    }
    var overlayImage: Uicorn.View.Image? {
        get {
            switch type {
            case let .overlay(v): return v.image
            default: return nil
            }
        }
        set {
            type = .overlay(newValue.map { .image($0) } ?? .empty)
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
    var canAddItem: Bool {
        switch self {
        case .opacity, .padding, .cornerRadius, .frame, .background, .blendMode, .overlay:
            return true
        }
    }
    static var sanitizedCases: [Self] {
        allCases.filter { $0.canAddItem }
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
        case .overlay: self.init(type: .overlay(.randomRemoteImage))
        case .padding: self.init(type: .padding(.zero))
        case .frame: self.init(type: .frame(.default))
        case .blendMode: self.init(type: .blendMode(.normal))
        case .cornerRadius: self.init(type: .cornerRadius(0))
        case .background: self.init(type: .background(.color(.system(.background))))
        }
    }
}

extension Uicorn.View.Modifier {
    var title: String {
        ViewModifier(type).localizedString
    }
}
