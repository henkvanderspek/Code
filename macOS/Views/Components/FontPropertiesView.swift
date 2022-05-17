//
//  FontPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 17/05/2022.
//


import SwiftUI

struct FontPropertiesView: View {
    @Binding var model: Uicorn.Font
    var body: some View {
        Section {
            Header("Type")
            Picker("Type", selection: $model.type) {
                ForEach(Uicorn.Font.allTypeCases, id: \.self) {
                    Text($0.localizedString)
                }
            }
            Header("Weight")
            Picker("Weight", selection: $model.weight) {
                ForEach(Uicorn.Font.allWeightCases, id: \.self) {
                    Text($0.localizedString)
                }
            }
        }
        .labelsHidden()
        .id(UUID())
    }
}

struct FontPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        FontPropertiesView(model: .constant(.default))
    }
}
