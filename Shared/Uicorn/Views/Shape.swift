//
//  Shape.swift
//  Uicorn
//
//  Created by Henk van der Spek on 13/05/2022.
//

import SwiftUI

extension Uicorn {
    static let defaultRoundedRectangleCornerRadius = 15
}

extension UicornView {
    struct Shape: View {
        @Binding var model: Uicorn.View.Shape
        private var host: UicornHost
        init(_ m: Binding<Uicorn.View.Shape>, host h: UicornHost) {
            _model = m
            host = h
        }
        var body: some View {
            switch model.type {
            case .rectangle:
                Rectangle()
                    .fill(Color(model.fill))
            case .roundedRectangle:
                RoundedRectangle(cornerRadius: .init(model.cornerRadius ?? Uicorn.defaultRoundedRectangleCornerRadius))
                    .fill(Color(model.fill))
            case .ellipse:
                Ellipse()
                    .fill(Color(model.fill))
            case .capsule:
                Capsule()
                    .fill(Color(model.fill))
            }
        }
    }
}

struct UicornView_Shape_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Shape(.constant(.rectangle(.system(.cyan))), host: MockHost())
    }
}
