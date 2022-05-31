//
//  Instance.swift
//  Code
//
//  Created by Henk van der Spek on 30/05/2022.
//

import SwiftUI

extension UicornView {
    struct Instance: View {
        @EnvironmentObject private var componentController: ComponentController
        @Binding var model: Uicorn.View.Instance
        init(_ m: Binding<Uicorn.View.Instance>) {
            _model = m
        }
        var body: some View {
            if let $v = componentController.instance(from: $model.wrappedValue.componentId) {
                UicornView($v, valueProvider: .init(instance: $model.wrappedValue))
            } else {
                EmptyView()
            }
        }
    }
}

struct Instance_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Instance(.constant(.init(componentId: .unique, values: [:])))
    }
}
