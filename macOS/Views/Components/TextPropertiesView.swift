//
//  TextPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 17/05/2022.
//

import SwiftUI

struct TextPropertiesView: View {
    @Binding var model: Uicorn.View.Text
    var body: some View {
        Section {
            FontPropertiesView(model: $model.font)
        }
    }
}

struct TextPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        TextPropertiesView(model: .constant(.init("", font: .default)))
    }
}
