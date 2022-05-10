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
        init(_ m: Binding<Uicorn.View.ZStack>, host: UicornHost) {
            _model = m
        }
        var body: some View {
            SwiftUI.ZStack {
                ForEach($model.children) {
                    UicornView($0)
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
