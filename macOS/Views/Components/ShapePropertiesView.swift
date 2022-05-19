//
//  ShapePropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 16/05/2022.
//

import SwiftUI

struct ShapePropertiesView: View {
    @Binding var model: Uicorn.View.Shape
    init(_ m: Binding<Uicorn.View.Shape>) {
        _model = m
    }
    var body: some View {
        Section {
            Header("Type")
            Picker("Type", selection: $model.type) {
                ForEach(Uicorn.View.Shape.allTypeCases, id: \.self) {
                    Text($0.localizedTitle)
                }
            }
            ColorPropertiesView(header: "Color", model: $model.fill)
        }
        .labelsHidden()
        .id(UUID())
    }
}

struct ShapePropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        ShapePropertiesView(.constant(.rectangle(.system(.cyan))))
    }
}
