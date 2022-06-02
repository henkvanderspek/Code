//
//  UicornView+Color.swift
//  Code
//
//  Created by Henk van der Spek on 02/06/2022.
//

import SwiftUI

extension UicornView {
    struct Color: View {
        @Binding var model: Uicorn.Color
        init(_ m: Binding<Uicorn.Color>) {
            _model = m
        }
        var body: some View {
            SwiftUI.Color($model.wrappedValue)
        }
    }
}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Color(.constant(.random))
    }
}

extension Uicorn.Color: Bindable {}
