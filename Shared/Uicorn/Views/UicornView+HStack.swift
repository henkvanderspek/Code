//
//  UicornView+HStack.swift
//  Code
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

extension UicornView {
    struct HStack: View {
        @Binding var model: Uicorn.View.HStack
        init(_ m: Binding<Uicorn.View.HStack>) {
            _model = m
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
        UicornView.HStack(.constant(.init([], alignment: .center, spacing: 0)))
    }
}
