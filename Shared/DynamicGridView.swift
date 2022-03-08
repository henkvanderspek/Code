//
//  DynamicGridView.swift
//  Code
//
//  Created by Henk van der Spek on 01/03/2022.
//

import SwiftUI

struct DynamicGridView: View {
    @State private var text: String = "f"
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            GridView(rows: 12, cols: 16, text: $text)
                .frame(width: 480)
            Form {
                Section(header: Text("Text")) {
                    TextField("", text: $text)
                }
                Section(header: Text("Colors")) {
                }
            }
            .frame(width: 160)
            .padding()
        }
        .frame(height: 480)
    }
}

struct DynamicGridView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicGridView()
    }
}
