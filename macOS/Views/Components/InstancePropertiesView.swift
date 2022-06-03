//
//  InstancePropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 30/05/2022.
//

import SwiftUI

struct InstancePropertiesView: View {
    @EnvironmentObject private var componentController: ComponentController
    @Binding var model: Uicorn.View.Instance
    init(_ m: Binding<Uicorn.View.Instance>) {
        _model = m
    }
    var body: some View {
        Section {
            Header("Component")
            Picker("Component", selection: $model.componentId) {
                ForEach(componentController.components ?? [], id: \.id) {
                    Text($0.title)
                }
            }
            if let id = $model.wrappedValue.componentId, let c = componentController.component(from: id) {
                VGroup {
                    ForEach(c.parameters, id: \.id) {
                        switch $0.wrappedValue.type {
                        case .string:
                            TextFieldView(value: string(for: $0.wrappedValue.viewId), header: $0.title.wrappedValue)
                        case .int:
                            Text("TODO: int input")
                        }
                    }
                }
            }
        }.labelsHidden()
    }
}

private extension InstancePropertiesView {
    func string(for key: String) -> Binding<String> {
        .init(
            get: {
                $model.wrappedValue.string(for: key)
            },
            set: {
                $model.wrappedValue.values[key] = .string($0)
            }
        )
    }
    func int(for key: String) -> Binding<Int> {
        .init(
            get: {
                $model.wrappedValue.int(for: key)
            },
            set: {
                $model.wrappedValue.values[key] = .int($0)
            }
        )
    }
}

struct ComponentPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        InstancePropertiesView(.constant(.init(id: .unique, componentId: .postComponentId, values: [:])))
    }
}
