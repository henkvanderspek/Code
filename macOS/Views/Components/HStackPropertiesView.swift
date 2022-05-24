//
//  HStackPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 23/05/2022.
//

import SwiftUI

struct HStackPropertiesView: View {
    @Binding var model: Uicorn.View.HStack
    init(_ m: Binding<Uicorn.View.HStack>) {
        _model = m
    }
    var body: some View {
        Section {
            HStack {
                VStack(alignment: .leading) {
                    Header("Alignment")
                    Picker("Alignment", selection: $model.alignment) {
                        ForEach(Uicorn.VerticalAlignment.allCases, id: \.self) {
                            Text($0.localizedString)
                        }
                    }
                }
                StepperView(Binding($model.spacing), default: 0, range: 0...1000, header: "Spacing")
            }
        }.labelsHidden()
    }
}

struct HStackPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        HStackPropertiesView(.constant(.init([], spacing: 0)))
    }
}
