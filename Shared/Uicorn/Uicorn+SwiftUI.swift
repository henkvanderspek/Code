//
//  Uicorn+SwiftUI.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

struct UicornView: View {
    @Binding var view: Uicorn.View
    init(_ v: Binding<Uicorn.View>) {
        _view = v
    }
    var body: some View {
        content
    }
}

private extension UicornView {
    @ViewBuilder var content: some View {
        switch $view.wrappedValue.type {
        case let .hstack(v):
            HStack(
                .init(
                    get: {
                        v.children
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
        case .spacer:
            SwiftUI.Text("Spacer")
        case .empty:
            SwiftUI.Text("Empty")
        }
    }
}

extension Uicorn.Screen: Identifiable {}
extension Uicorn.View: Identifiable {}
