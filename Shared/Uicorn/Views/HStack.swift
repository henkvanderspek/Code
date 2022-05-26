//
//  HStack.swift
//  Code
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

extension UicornView {
    struct HStack: View {
        @Binding var model: Uicorn.View.HStack
        private var host: UicornHost
        init(_ m: Binding<Uicorn.View.HStack>, host h: UicornHost) {
            _model = m
            host = h
        }
        var body: some View {
            SwiftUI.HStack(alignment: .init($model.alignment.wrappedValue), spacing: .init($model.spacing.wrappedValue)) {
                ForEach($model.children) {
                    UicornView($0)
                }
            }
        }
    }
}

struct HStack_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.HStack(.constant(.init([], spacing: 0)), host: MockHost())
    }
}
