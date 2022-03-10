//
//  JsonUI+Text.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import SwiftUI

extension JsonUIView {
    struct Text: View {
        let id = UUID()
        let view: JsonUI.View.Text
        init(_ v: JsonUI.View.Text) {
            view = v
        }
        var body: some View {
            SwiftUI.Text(view.value)
        }
    }
}

struct JsonUIView_Text_Previews: PreviewProvider {
    static var previews: some View {
        JsonUIView.Text(.init(value: "Foo"))
    }
}
