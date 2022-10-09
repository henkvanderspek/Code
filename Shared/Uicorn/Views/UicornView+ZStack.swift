//
//  UicornView+ZStack.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import SwiftUI

extension UicornView {
    struct ZStack: View {
        @Binding var model: Uicorn.View.ZStack
        init(_ m: Binding<Uicorn.View.ZStack>) {
            _model = m
        }
        var body: some View {
            SwiftUI.ZStack(alignment: .init($model.alignment.wrappedValue)) {
                ForEach($model.children) {
                    UicornView($0)
                }
            }
        }
    }
}

struct ZStack_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.ZStack(.constant(.init([])))
    }
}

extension Uicorn.View.ZStack {
    var reversedEnumeratedChildren: Array<EnumeratedSequence<Uicorn.View>.Element> {
        get { Array(children.reversed().enumerated()) }
        set {}
    }
}
