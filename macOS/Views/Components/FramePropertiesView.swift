//
//  FramePropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 26/05/2022.
//

import SwiftUI

struct FramePropertiesView: View {
    @Binding var model: Uicorn.Frame
    init(_ m: Binding<Uicorn.Frame>) {
        _model = m
    }
    var body: some View {
        Section {
            HStack {
                StepperView($model.width, default: 0, range: 0...1000, step: 1, header: "Width")
                StepperView($model.height, default: 0, range: 0...1000, step: 1, header: "Height")
            }
            // TODO: Study this a bit more, doesn't seem to have much effect
//            Header("Alignment")
//            Picker("Alignment", selection: $model.alignment) {
//                ForEach(Uicorn.Alignment.allCases, id: \.self) {
//                    Text($0.localizedString)
//                }
//            }
        }.labelsHidden()
    }
}

struct FramePropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        FramePropertiesView(.constant(.default))
    }
}
