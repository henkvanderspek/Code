//
//  ZStackPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 24/05/2022.
//

import SwiftUI

struct ZStackPropertiesView: View {
    @Binding var model: Uicorn.View.ZStack
    init(_ m: Binding<Uicorn.View.ZStack>) {
        _model = m
    }
    var body: some View {
        Section {
            Header("Alignment")
            Picker("Alignment", selection: $model.alignment) {
                ForEach(Uicorn.Alignment.allCases, id: \.self) {
                    Text($0.localizedString)
                }
            }
        }.labelsHidden()
    }
}

struct ZStackPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        ZStackPropertiesView(.constant(.init([])))
    }
}
