//
//  Uicorn+SwiftUI.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

struct UicornView: View {
    let view: Uicorn.View
    init(_ v: Uicorn.View) {
        view = v
    }
    var body: some View {
        content
    }
}

extension Uicorn.Screen: Identifiable {}
extension Uicorn.View: Identifiable {}

private extension UicornView {
    @ViewBuilder var content: some View {
        switch view.type {
        case let .hstack(v):
            HStack(v.children)
        case .empty:
            EmptyView()
        }
    }
}

extension UicornView {
    struct HStack: View {
        let children: [Uicorn.View]
        init(_ c: [Uicorn.View]) {
            children = c
        }
        var body: some View {
            SwiftUI.HStack {
                ForEach(children) {
                    UicornView($0)
                }
            }
        }
    }
}
