//
//  VStack.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import SwiftUI

extension UicornView {
    struct VStack: View {
        @Binding var model: Uicorn.View.VStack
        init(_ m: Binding<Uicorn.View.VStack>) {
            _model = m
        }
        var body: some View {
            SwiftUI.VStack(alignment: .init($model.alignment.wrappedValue), spacing: .init($model.spacing.wrappedValue)) {
                ForEach($model.children) {
                    UicornView($0)
                }
            }
        }
    }
}

struct VStack_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.VStack(.constant(.init([], alignment: .center, spacing: 0)))
    }
}
