//
//  Text.swift
//  Uicorn
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

extension UicornView {
    struct Text: View {
        @Binding var model: Uicorn.View.Text
        private var host: UicornHost
        init(_ m: Binding<Uicorn.View.Text>, host h: UicornHost) {
            _model = m
            host = h
        }
        var body: some View {
            SwiftUI.Text($model.wrappedValue.value)
                .font(.init($model.font.type.wrappedValue))
                .fontWeight(.init($model.font.weight.wrappedValue))
        }
    }
}


struct UicornView_Text_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Text(.constant(.init("Foo", font: .default)), host: MockHost())
    }
}
