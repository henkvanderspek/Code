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
                TextFieldView(value: $model.remote.url, header: "URL")
            case .system:
                TextFieldView(value: $model.system.name, header: "Name")
                HGroup {
                    VStack(alignment: .leading) {
                        Header("Type")
                        Picker("Type", selection: $model.system.type) {
                            ForEach(Uicorn.Font.allTypeCases, id: \.self) {
                                Text($0.localizedString)
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        Header("Weight")
                        Picker("Weight", selection: $model.system.weight) {
                            ForEach(Uicorn.Font.Weight.allCases, id: \.self) {
                                Text($0.localizedString)
                            }
                        }
                    }
                }
                HGroup {
                    VStack(alignment: .leading) {
                        Header("Scale")
                        Picker("Scale", selection: $model.system.scale) {
                            ForEach(Uicorn.ImageScale.allCases, id: \.self) {
                                Text($0.localizedString)
                            }
                        }
                    }
                    GreedySpacer()
                }
                Divider()
                OptionalPropertiesView(header: "Color", value: $model.system.fill, defaultValue: .system(.label)) {
                    ColorPropertiesView(
                        header: "Color",
                        model: $0,
                        showHeader: false
                    )
                }
            }
        }
        .labelsHidden()
    }
}

struct ImagePropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePropertiesView(.constant(.randomSystem(fill: .system(.yellow))))
    }
}
