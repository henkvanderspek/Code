//
//  JsonUI+Color.swift
//  Code
//
//  Created by Henk van der Spek on 11/03/2022.
//

import SwiftUI

extension View {
    func foregroundColor(_ c: JsonUI.View.Attributes.Color?) -> some View {
        guard let c = c else { return AnyView(self) }
        return AnyView(foregroundColor(Color(c)))
    }
    func backgroundColor(_ c: JsonUI.View.Attributes.Color?) -> some View {
        guard let c = c else { return AnyView(self) }
        return AnyView(background(Color(c)))
    }
}

extension Color {
    init(_ c: JsonUI.View.Attributes.Color) {
        self.init(c.value)
    }
}
