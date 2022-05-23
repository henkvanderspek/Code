//
//  VStackPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 23/05/2022.
//

import SwiftUI

struct VStackPropertiesView: View {
    @Binding var model: Uicorn.View.VStack
    init(_ m: Binding<Uicorn.View.VStack>) {
        _model = m
    }
    var body: some View {
        Section {
            StepperView(Binding($model.spacing), default: 0, range: 0...1000, header: "Spacing")
        }.labelsHidden()
    }
}

struct VStackPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        VStackPropertiesView(.constant(.init([], spacing: 0)))
    }
}
