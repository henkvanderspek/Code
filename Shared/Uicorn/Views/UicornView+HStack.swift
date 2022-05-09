//
//  UicornView+HStack.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

extension UicornView {
    struct HStack: View {
        @Binding var children: [Uicorn.View]
        init(_ c: Binding<[Uicorn.View]>) {
            _children = c
        }
        var body: some View {
            SwiftUI.HStack {
                ForEach($children) {
                    UicornView($0)
                }
            }
        }
    }
}

struct UicornView_HStack_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.HStack(.constant([]))
    }
}
