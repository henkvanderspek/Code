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
            Header("Shape")
            Picker("Shape", selection: $model.type) {
                ForEach(Uicorn.View.Shape.allTypeCases, id: \.self) {
                    Text($0.localizedTitle)
                }
            }
            Divider()
            OptionalPropertiesView(header: "Color", value: $model.fill, defaultValue: .system(.background)) { value in
                ColorPropertiesView(
                    header: "Color",
                    model: .init(
                        get: {
                            value.wrappedValue
                        },
                        set: {
                            $model.fill.wrappedValue = $0
                        }
                    ),
                    showHeader: false
                )
            }
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
