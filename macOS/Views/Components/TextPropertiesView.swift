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
            TextEditorView(value: $model.value, header: "Text")
            HStack {
                VStack(alignment: .leading) {
                    Header("Alignment")
                    Picker("Alignment", selection: $model.alignment) {
                        ForEach(Uicorn.TextAlignment.allCases, id: \.self) {
                            Text($0.localizedString)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Header("Transform")
                    Picker("Transform", selection: $model.textCase) {
                        ForEach(Uicorn.TextCase.allCases, id: \.self) {
                            Text($0.localizedString)
                        }
                    }
                }
            }
            Divider()
            ColorPropertiesView(
                header: "Foreground Color",
                model: .init(
                    get: {
                        $model.foregroundColor.wrappedValue ?? .system(.label)
                    },
                    set: {
                        $model.foregroundColor.wrappedValue = $0
                    }
                )
            )
            Divider()
            FontPropertiesView(model: $model.font)
        }
        .labelsHidden()
    }
}

struct TextPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        TextPropertiesView(.constant(.init("", font: .default, alignment: .leading, textCase: .standard, foregroundColor: nil)))
    }
}
