//
//  PaddingPropertiesView.swift
//  Code
//
//  Created by Henk van der Spek on 18/05/2022.
//

import SwiftUI

struct PaddingPropertiesView: View {
    @Binding var model: Uicorn.Padding
    let showHeader: Bool
    private let `default` = 0
    init(_ m: Binding<Uicorn.Padding>, showHeader sh: Bool = true) {
        _model = m
        showHeader = sh
    }
    var body: some View {
        Section {
            StepperView(
                .init($model.all),
                default: `default`,
                range: 0...100,
                step: 1,
                header: "Padding",
                showHeader: showHeader
            )
        }
        .labelsHidden()
    }
}

struct PaddingPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        PaddingPropertiesView(.constant(.all(5)))
    }
}
