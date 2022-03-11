//
//  JsonUI+Color.swift
//  Code
//
//  Created by Henk van der Spek on 11/03/2022.
//

import SwiftUI

extension View {
    func foregroundColor(_ c: JsonUI.View.Attributes.Color?) -> some View {
        return foregroundColor(c.map { _ in .red }) // TODO: Map native color to SwiftUI color
    }
    func backgroundColor(_ c: JsonUI.View.Attributes.Color?) -> some View {
        guard let _ = c else { return AnyView(self) }
        return AnyView(background(.black)) // TODO: Map native color to SwiftUI color
    }
}
