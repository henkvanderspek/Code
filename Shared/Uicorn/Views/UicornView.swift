//
//  UicornView.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

typealias Resolve = (String) -> String

protocol UicornHost {
    func resolve(_ s: String) -> String
}

extension UicornHost {
    func resolve(_ s: String) -> String {
        return s
    }
}

struct UicornView: View {
    @Binding var model: Uicorn.View
    private let resolver: Resolve?
    init(_ v: Binding<Uicorn.View>, resolver r: Resolve? = nil) {
        _model = v
        resolver = r
    }
    var body: some View {
        content
    }
}

extension UicornView: UicornHost {
    func resolve(_ s: String) -> String {
        resolver?(s) ?? s
    }
}

struct MockHost: UicornHost {}

private extension UicornView {
    @ViewBuilder var content: some View {
        switch $model.wrappedValue.type {
        case let .hstack(v):
            HStack(v.binding, host: self)
        case let .vstack(v):
            VStack(v.binding, host: self)
        case let .zstack(v):
            ZStack(v.binding, host: self)
        case let .text(t):
            Text(t.binding, host: self)
        case let .image(i):
            Image(i.binding, host: self)
        case let .collection(c):
            Collection(c.binding, host: self)
        case .spacer:
            SwiftUI.Text("Spacer")
        case .empty:
            SwiftUI.Text("Empty")
        }
    }
}

extension UicornViewType {
    var binding: Binding<Self> {
        .init(
            get: {
                self
            },
            set: {
                print($0)
            }
        )
    }
}
