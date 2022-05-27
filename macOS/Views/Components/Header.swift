//
//  Header.swift
//  macOS
//
//  Created by Henk van der Spek on 13/05/2022.
//

import SwiftUI

struct Header: View {
    let text: String
    let font: Font?
    let fontWeight: Font.Weight?
    init(_ s: String, font f: Font? = nil, fontWeight w: Font.Weight? = nil) {
        text = s
        font = f
        fontWeight = w
    }
    var body: some View {
        Text(text)
            .font(font ?? .headline)
            .fontWeight(fontWeight ?? .light)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header("Foo")
    }
}
