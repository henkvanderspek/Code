//
//  JsonUI+VStack.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import SwiftUI

extension JsonUIView {
    struct VStack: View {
        let children: [JsonUI.View]
        init(_ c: [JsonUI.View]) {
            children = c
        }
        var body: some View {
            SwiftUI.VStack {
                ForEach(children) {
                    JsonUIView($0)
                }
            }
        }
    }
}

struct JsonUIView_VStack_Previews: PreviewProvider {
    static var previews: some View {
        JsonUIView.VStack([])
    }
}
