//
//  Shape.swift
//  Code
//
//  Created by Henk van der Spek on 13/05/2022.
//

import SwiftUI

extension UicornView {
    struct Shape: View {
        @Binding var model: Uicorn.View.Shape
        init(_ m: Binding<Uicorn.View.Shape>) {
            _model = m
        }
        var body: some View {
            let c = Color(model.fill ?? .system(.background))
            switch model.type {
            case .rectangle:
                Rectangle()
                    .fill(c)
            case .ellipse:
                Ellipse()
                    .fill(c)
            case .capsule:
                Capsule()
                    .fill(c)
            case .circle:
                Circle()
                    .fill(c)
            }
        }
    }
}

struct Shape_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Shape(.constant(.rectangle(.system(.cyan))))
    }
}
