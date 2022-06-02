//
//  ModifiersView.swift
//  macOS
//
//  Created by Henk van der Spek on 02/06/2022.
//

import SwiftUI

struct ModifiersView: View {
    @Binding var model: Uicorn.View.Modifiers
    init(_ m: Binding<Uicorn.View.Modifiers>) {
        _model = m
    }
    var body: some View {
        Text("Hello, Modifiers!")
    }
}

struct ModifiersPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        ModifiersView(.constant([]))
    }
}
