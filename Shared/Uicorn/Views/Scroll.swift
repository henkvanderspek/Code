//
//  Scroll.swift
//  Code
//
//  Created by Henk van der Spek on 26/05/2022.
//

import SwiftUI

extension UicornView {
    struct Scroll: View {
        @Binding var model: Uicorn.View.Scroll
        private let valueProvider: ValueProvider?
        init(_ m: Binding<Uicorn.View.Scroll>, valueProvider v: ValueProvider? = nil) {
            _model = m
            valueProvider = v
        }
        var body: some View {
            SwiftUI.ScrollView(.init($model.axis.wrappedValue)) {
                SwiftUI.VStack(spacing: 0) {
                    ForEach($model.children) {
                        UicornView($0, valueProvider: valueProvider)
                    }
                }
            }
        }
    }
}

struct Scroll_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Scroll(.constant(.init(axis: .horizontal, children: [.mock])))
    }
}
