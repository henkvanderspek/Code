//
//  UicornView+Instance.swift
//  Code
//
//  Created by Henk van der Spek on 30/05/2022.
//

import SwiftUI

extension UicornView {
    struct Instance: View {
        @EnvironmentObject private var componentController: ComponentController
        @EnvironmentObject private var valueProvider: ValueProvider
        @Binding var model: Uicorn.View.Instance
        init(_ m: Binding<Uicorn.View.Instance>) {
            _model = m
        }
        var body: some View {
            if let $v = componentController.instance(from: $model.wrappedValue.componentId) {
                UicornView($v)
                    .onAppear {
                        valueProvider.addChild(InstanceValueProvider(instance: $model.wrappedValue))
                    }
            } else {
                EmptyView()
            }
        }
    }
}

struct Instance_Previews: PreviewProvider {
    static var view: Uicorn.View = .postInstance
    static var app: Uicorn.App = .init(id: .unique, title: .init(), color: .random, screens: [.init(id: .unique, title: .init(), view: view)], components: [.post])
    static var componentController = ComponentController()
    static var valueProvider = EmptyValueProvider()
    static var previews: some View {
        UicornView(.constant(view))
            .environmentObject(componentController)
            .environmentObject(valueProvider)
            .onAppear {
                componentController.app = .constant(app)
            }
    }
}
