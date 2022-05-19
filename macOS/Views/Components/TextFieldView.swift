//
//  TextFieldView.swift
//  macOS
//
//  Created by Henk van der Spek on 19/05/2022.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var value: String
    let header: String
    var body: some View {
        Header(header)
        VStack {
            TextField(header, text: $value)
                .textFieldStyle(.plain)
                .padding(4)
        }
        .background(.background)
        .cornerRadius(4)
    }
}

struct TextFieldVIew_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(value: .constant("https://vdbyte.com"), header: "URL")
    }
}
