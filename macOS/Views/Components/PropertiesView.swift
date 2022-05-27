//
//  PropertiesView.swift
//  Code
//
//  Created by Henk van der Spek on 18/05/2022.
//

import SwiftUI

struct PropertiesView: View {
    @Binding var model: Uicorn.Properties
    @State var showAppearance: Bool?
    init(_ m: Binding<Uicorn.Properties>) {
        _model = m
    }
    var body: some View {
//        Divider()
//        OptionalPropertiesView(header: "Appearance", value: $showAppearance, defaultValue: false) { _ in
//        }
        Divider()
        OptionalPropertiesView(header: "Layout", value: $model.frame, defaultValue: .default) { value in
            Section {
                FramePropertiesView(
                    .init(
                        get: { value.wrappedValue },
                        set: { $model.frame.wrappedValue = $0 }
                    )
                )
                HStack {
                    PaddingPropertiesView($model.padding)
                    StepperView(Binding($model.cornerRadius), default: 0, range: 0...1000, step: 1, header: "Corner Radius")
                }
                HStack {
                    StepperView($model.opacity, default: 1.0, range: 0...1, step: 0.1, header: "Opacity")
                    GreedySpacer()
                }
            }
            .labelsHidden()
        }
        Divider()
        OptionalPropertiesView(header: "Background Color", value: $model.backgroundColor, defaultValue: .system(.background)) { value in
            ColorPropertiesView(
                header: "Background Color",
                model: .init(
                    get: { value.wrappedValue },
                    set: { $model.backgroundColor.wrappedValue = $0 }
                ),
                showHeader: false
            )
        }
    }
}

struct PropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesView(.constant(.empty))
    }
}
