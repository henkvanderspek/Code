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
            // TODO: Create picker with components
            if let $c = componentController.component(from: $model.wrappedValue.componentId) {
                TextFieldView(value: .constant($c.wrappedValue.title), header: "Component")
            } else {
                EmptyView()
            }
            
        }.labelsHidden()
    }
}

struct ComponentPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        InstancePropertiesView(.constant(.init(componentId: .cardComponentId)))
    }
}
