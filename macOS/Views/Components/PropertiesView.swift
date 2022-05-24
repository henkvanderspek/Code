//
//  PropertiesView.swift
//  Code
//
//  Created by Henk van der Spek on 18/05/2022.
//

import SwiftUI

struct PropertiesView: View {
    @Binding var model: Uicorn.Properties
    init(_ m: Binding<Uicorn.Properties>) {
        _model = m
    }
    var body: some View {
        Divider()
        ColorPropertiesView(
            header: "Background Color",
            model: .init(
                get: {
                    $model.backgroundColor.wrappedValue ?? .system(.background)
                },
                set: {
                    $model.backgroundColor.wrappedValue = $0
                }
            )
        )
        Divider()
        Section {
            HStack {
                PaddingPropertiesView($model.padding)
                StepperView(Binding($model.cornerRadius), default: 0, range: 0...1000, header: "Corner Radius")
            }
        }.labelsHidden()
    }
}

struct PropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesView(.constant(.empty))
    }
}
