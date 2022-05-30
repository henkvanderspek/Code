//
//  ZStack.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import SwiftUI

extension UicornView {
    struct ZStack: View {
        @Binding var model: Uicorn.View.ZStack
        private var host: UicornHost
        init(_ m: Binding<Uicorn.View.ZStack>, host h: UicornHost) {
            _model = m
            host = h
        }
        var body: some View {
            SwiftUI.ZStack(alignment: .init($model.alignment.wrappedValue)) {
                ForEach($model.reversedEnumeratedChildren, id: \.offset) { v in
                    UicornView(v.element)
                }
            }
        }
    }
}

struct ZStack_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.ZStack(.constant(.init([])), host: .mock)
    }
}

extension Uicorn.View.ZStack {
    var reversedEnumeratedChildren: Array<EnumeratedSequence<Uicorn.View>.Element> {
        get { Array(children.reversed().enumerated()) }
        set {}
    }
}
