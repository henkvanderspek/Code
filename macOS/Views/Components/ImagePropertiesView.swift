//
//  ImagePropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 19/05/2022.
//

import SwiftUI

struct ImagePropertiesView: View {
    @Binding var model: Uicorn.View.Image
    init(_ m: Binding<Uicorn.View.Image>) {
        _model = m
    }
    var body: some View {
        Section {
            switch model.type {
            case .remote:
                TextFieldView(value: $model.value, header: "URL")
            case .system:
                TextFieldView(value: $model.value, header: "Name")
                ColorPropertiesView(
                    header: "Color",
                    model: .init(
                        get: {
                            model.fill ?? .system(.label)
                        },
                        set: {
                            $model.fill.wrappedValue = $0
                        }
                    )
                )
            }
        }
        .labelsHidden()
    }
}

struct ImagePropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePropertiesView(.constant(.init(type: .system, value: "mustache", fill: .system(.yellow))))
    }
}
