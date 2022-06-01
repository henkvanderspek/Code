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
        init(_ m: Binding<Uicorn.View.Scroll>) {
            _model = m
        }
        var body: some View {
            SwiftUI.ScrollView(.init($model.axis.wrappedValue)) {
                SwiftUI.VStack(spacing: 0) {
                    ForEach($model.children) {
                        UicornView($0)
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
