//
//  UicornView.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

struct UicornView: View {
    @Binding var model: Uicorn.View
    init(_ v: Binding<Uicorn.View>) {
        _model = v
    }
    var body: some View {
        content
    }
}

private extension UicornView {
    @ViewBuilder var content: some View {
        switch $model.wrappedValue.type {
        case let .hstack(v):
            HStack(
                .init(
                    get: {
                        v
                    },
                    set: {
                        print($0)
                    }
                )
            )
        case let .text(t):
            Text(
                .init(
                    get: {
                        t.value
                    },
                    set: {
                        print($0)
                    }
                )
            )
        case let .image(i):
            Image(
                .init(
                    get: {
                        i
                    },
                    set: {
                        print($0)
                    }
                )
            )
        case .spacer:
            SwiftUI.Text("Spacer")
        case .empty:
            SwiftUI.Text("Empty")
        }
    }
}

