//
//  TextPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 17/05/2022.
//

import SwiftUI

struct TextPropertiesView: View {
    @Binding var model: Uicorn.View.Text
    init(_ m: Binding<Uicorn.View.Text>) {
        _model = m
    }
    var body: some View {
        Section {
            FontPropertiesView(model: $model.font)
            // TODO: text alignment
        }
        .labelsHidden()
    }
}

struct TextPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        TextPropertiesView(.constant(.init("", font: .default)))
    }
}
