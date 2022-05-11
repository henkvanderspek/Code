//
//  UicornView+VStack.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import SwiftUI

extension UicornView {
    struct VStack: View {
        @Binding var model: Uicorn.View.VStack
        private var host: UicornHost
        init(_ m: Binding<Uicorn.View.VStack>, host h: UicornHost) {
            _model = m
            host = h
        }
        var body: some View {
            SwiftUI.VStack(spacing: .init($model.spacing.wrappedValue)) {
                ForEach($model.children) {
                    UicornView($0)
                }
            }
        }
    }
}

struct UicornView_VStack_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.VStack(.constant(.init([], spacing: 0)), host: MockHost())
    }
}
