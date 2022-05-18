//
//  ZStack.swift
//  Uicorn
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
            SwiftUI.ZStack {
                ForEach($model.children.reversed()) {
                    UicornView($0, resolver: host.resolve)
                }
            }
        }
    }
}

struct UicornView_ZStack_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.ZStack(.constant(.init([])), host: MockHost())
    }
}
