//
//  ShapePropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 16/05/2022.
//

import SwiftUI

struct ShapePropertiesView: View {
    @Binding var model: Uicorn.View.Shape
    var body: some View {
        Section {
            Header("Type")
            Picker("Type", selection: $model.type) {
                ForEach(Uicorn.View.Shape.allTypeCases, id: \.self) {
                    Text($0.localizedTitle)
                }
            }
            ColorPropertiesView(header: "Color", model: $model.fill)
            switch model.type {
            case .roundedRectangle:
                Header("Corner Radius")
                HStack(spacing: 5) {
                    Text("\(model.cornerRadius ?? Uicorn.defaultRoundedRectangleCornerRadius)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Stepper("Corner Radius", value: Binding($model.cornerRadius, default: Uicorn.defaultRoundedRectangleCornerRadius), in: 1...1000)
                }
                .frame(width: 80)
                .background(.background)
                .cornerRadius(4)
            case .rectangle, .capsule, .ellipse:
                EmptyView()
            }
        }
        .labelsHidden()
        .id(UUID())
    }
}

struct ShapePropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        ShapePropertiesView(model: .constant(.rectangle(.system(.cyan))))
    }
}
