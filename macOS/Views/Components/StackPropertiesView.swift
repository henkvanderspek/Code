//
//  StackPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 02/06/2022.
//

import SwiftUI

struct StackPropertiesView: View {
    let type: Binding<Uicorn.View.`Type`>
    init(_ t: Binding<Uicorn.View.`Type`>) {
        type = t
    }
    fileprivate enum Axis: String, CaseIterable {
        case horizontal
        case vertical
        case depth
    }
    private var axis: Binding<Axis> {
        .init(
            get: {
                switch type.wrappedValue {
                case .hstack: return .horizontal
                case .vstack: return .vertical
                case .zstack: return .depth
                default: fatalError()
                }
            },
            set: {
                switch (type.wrappedValue, $0) {
                case (.hstack, .horizontal), (.vstack, .vertical), (.zstack, .depth):
                    print("Conversion not needed")
                case let (.vstack(v), .horizontal):
                    print("Convert stack from vertical to horizontal")
                    type.wrappedValue = .hstack(.init(v.children, alignment: .init(v.alignment), spacing: v.spacing))
                case let (.vstack(v), .depth):
                    print("Convert stack from vertical to depth")
                    type.wrappedValue = .zstack(.init(v.children, alignment: .init(v.alignment)))
                case let (.hstack(v), .vertical):
                    print("Convert stack from horizontal to vertical")
                    type.wrappedValue = .vstack(.init(v.children, alignment: .init(v.alignment), spacing: v.spacing))
                case let (.hstack(v), .depth):
                    print("Convert stack from horizontal to depth")
                    type.wrappedValue = .zstack(.init(v.children, alignment: .init(v.alignment)))
                case let (.zstack(v), .horizontal):
                    print("Convert stack from depth to horizontal")
                    type.wrappedValue = .hstack(.init(v.children, alignment: .init(v.alignment), spacing: 0))
                case let (.zstack(v), .vertical):
                    print("Convert stack from depth to vertical")
                    type.wrappedValue = .vstack(.init(v.children, alignment: .init(v.alignment), spacing: 0))
                default:
                    fatalError()
                }
            }
        )
    }
    private var hbinding: Binding<Uicorn.View.HStack> {
        switch type.wrappedValue {
        case let .hstack(s): return s.binding {
            type.wrappedValue = .hstack($0)
        }
        default: fatalError()
        }
    }
    private var vbinding: Binding<Uicorn.View.VStack> {
        switch type.wrappedValue {
        case let .vstack(s): return s.binding {
            type.wrappedValue = .vstack($0)
        }
        default: fatalError()
        }
    }
    private var zbinding: Binding<Uicorn.View.ZStack> {
        switch type.wrappedValue {
        case let .zstack(s): return s.binding {
            type.wrappedValue = .zstack($0)
        }
        default: fatalError()
        }
    }
    var body: some View {
        Section {
            Header("Axis")
            Picker("Axis", selection: axis) {
                ForEach(Axis.allCases, id: \.self) {
                    Text($0.localizedString)
                }
            }
            HGroup {
                switch type.wrappedValue {
                case .hstack:
                    VStack(alignment: .leading) {
                        Header("Alignment")
                        Picker("Alignment", selection: hbinding.alignment) {
                            ForEach(Uicorn.VerticalAlignment.allCases, id: \.self) {
                                Text($0.localizedString)
                            }
                        }
                    }
                    StepperView(Binding(hbinding.spacing), default: 0, range: 0...1000, step: 1, header: "Spacing")
                case .vstack:
                    VStack(alignment: .leading) {
                        Header("Alignment")
                        Picker("Alignment", selection: vbinding.alignment) {
                            ForEach(Uicorn.HorizontalAlignment.allCases, id: \.self) {
                                Text($0.localizedString)
                            }
                        }
                    }
                    StepperView(Binding(vbinding.spacing), default: 0, range: 0...1000, step: 1, header: "Spacing")
                case .zstack:
                    VStack(alignment: .leading) {
                        Header("Alignment")
                        Picker("Alignment", selection: zbinding.alignment) {
                            ForEach(Uicorn.Alignment.allCases, id: \.self) {
                                Text($0.localizedString)
                            }
                        }
                    }
                default: fatalError()
                }
            }
        }.labelsHidden()
    }
}
struct StackPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        StackPropertiesView(.constant(.hstack(.init([], alignment: .center, spacing: 0))))
    }
}

private extension StackPropertiesView.Axis {
    var localizedString: String {
        switch self {
        case .horizontal: return "Horizontal"
        case .vertical: return "Vertical"
        case .depth: return "Depth"
        }
    }
}

