//
//  ScrollPropertiesView.swift
//  Code
//
//  Created by Henk van der Spek on 26/05/2022.
//

import SwiftUI

struct ScrollPropertiesView: View {
    @Binding var model: Uicorn.View.Scroll
    init(_ m: Binding<Uicorn.View.Scroll>) {
        _model = m
    }
    var body: some View {
        Section {
            Header("Axis")
            Picker("Axis", selection: $model.axis) {
                ForEach(Uicorn.Axis.allCases, id: \.self) {
                    Text($0.localizedString)
                }
            }
        }.labelsHidden()
    }
}

struct ScrollPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPropertiesView(.constant(.init(axis: .horizontal, children: [])))
    }
}
