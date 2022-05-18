//
//  PropertiesView.swift
//  Code
//
//  Created by Henk van der Spek on 18/05/2022.
//

import SwiftUI

struct PropertiesView: View {
    @Binding var properties: Uicorn.Properties
    init(_ p: Binding<Uicorn.Properties>) {
        _properties = p
    }
    var body: some View {
        PaddingPropertiesView($properties.padding)
        Section {
            StepperView(Binding($properties.cornerRadius), default: 0, range: 0...1000, header: "Corner Radius")
        }.labelsHidden()
    }
}

struct PropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesView(.constant(.empty))
    }
}
