//
//  UicornView+Color.swift
//  Code
//
//  Created by Henk van der Spek on 13/05/2022.
//

import SwiftUI

extension UicornView {
    struct Color: View {
        @Binding var model: Uicorn.View.Color
        private var host: UicornHost
        init(_ m: Binding<Uicorn.View.Color>, host h: UicornHost) {
            _model = m
            host = h
        }
        var body: some View {
            SwiftUI.Color($model.wrappedValue)
        }
    }
}

struct UicornView_Color_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Color(.constant(.system(.yellow)), host: MockHost())
    }
}
