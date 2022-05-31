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
        }.labelsHidden()
    }
}

struct ComponentPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        InstancePropertiesView(.constant(.init(componentId: .cardComponentId)))
    }
}
