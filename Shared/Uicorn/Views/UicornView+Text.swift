//
//  UicornView+Text.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

extension UicornView {
    struct Text: View {
        @Binding var model: Uicorn.View.Text
        init(_ m: Binding<Uicorn.View.Text>, host: UicornHost) {
            _model = m
        }
        var body: some View {
            SwiftUI.Text($model.wrappedValue.value)
        }
    }
}


struct UicornView_Text_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Text(.constant(.init("Foo")), host: MockHost())
    }
}
