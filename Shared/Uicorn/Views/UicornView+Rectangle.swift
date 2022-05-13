//
//  UicornView+Rectangle.swift
//  Code
//
//  Created by Henk van der Spek on 13/05/2022.
//

import SwiftUI

extension UicornView {
    struct Rectangle: View {
        @Binding var model: Uicorn.View.Rectangle
        private var host: UicornHost
        init(_ m: Binding<Uicorn.View.Rectangle>, host h: UicornHost) {
            _model = m
            host = h
        }
        var body: some View {
            SwiftUI
                .Rectangle()
                .fill(SwiftUI.Color(model.fill))
        }
    }
}


struct UicornView_Rectangle_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Rectangle(.constant(.init(fill: .system(.pink))), host: MockHost())
    }
}
