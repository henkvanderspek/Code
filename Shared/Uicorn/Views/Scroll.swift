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
        private var host: UicornHost
        init(_ m: Binding<Uicorn.View.Scroll>, host h: UicornHost) {
            _model = m
            host = h
        }
        var body: some View {
            SwiftUI.ScrollView(.init($model.axis.wrappedValue)) {
                ForEach($model.children) {
                    UicornView($0, resolver: host.resolve)
                }
            }
        }
    }
}

struct Scroll_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Scroll(.constant(.init(axis: .horizontal, children: [.mock])), host: .mock)
    }
}
