//
//  Header.swift
//  macOS
//
//  Created by Henk van der Spek on 13/05/2022.
//

import SwiftUI

struct Header: View {
    let text: String
    init(_ s: String) {
        text = s
    }
    var body: some View {
        Text(text)
            .font(.headline)
            .fontWeight(.light)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header("Foo")
    }
}
