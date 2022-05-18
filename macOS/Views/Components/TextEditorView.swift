//
//  TextEditorView.swift
//  Code
//
//  Created by Henk van der Spek on 18/05/2022.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var value: String
    let header: String
    var body: some View {
        Header(header)
        VStack {
            TextEditor(text: $value)
                .frame(minHeight: 100)
                .padding(6)
        }
        .background(.background)
        .cornerRadius(4)
        .frame(minHeight: 20)
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(value: .constant("Foo"), header: "Title")
    }
}
