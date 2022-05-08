//
//  UicornView+Text.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

extension UicornView {
    struct Text: View {
        @Binding var value: String
        init(_ v: Binding<String>) {
            _value = v
        }
        var body: some View {
            SwiftUI.Text($value.wrappedValue)
        }
    }
}


struct UicornView_Text_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Text(.constant("Foo"))
    }
}
