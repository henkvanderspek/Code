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
        private var host: UicornHost
        init(_ m: Binding<Uicorn.View.Instance>, host h: UicornHost) {
            _model = m
            host = h
        }
        var body: some View {
            if let $v = componentController.instance(from: $model.wrappedValue.componentId) {
                UicornView($v)
            } else {
                EmptyView()
            }
        }
    }
}

struct Instance_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Instance(.constant(.init(componentId: .unique)), host: .mock)
    }
}
