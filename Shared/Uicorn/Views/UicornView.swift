//
//  UicornView.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

enum ResolveContext {
    case `default`
    case sheet
}

typealias Resolve = (String, ResolveContext) -> String

protocol UicornHost {
    func resolve(_ s: String, context: ResolveContext) -> String
}

extension UicornHost {
    func resolve(_ s: String, context: ResolveContext) -> String {
        return s
    }
    func resolve(_ s: String) -> String {
        return resolve(s, context: .default)
    }
}

struct UicornView: View {
    @Binding var model: Uicorn.View
    private let resolver: Resolve?
    @State private var sheetView: AnyView?
    @State private var shouldShowSheet = false
    init(_ v: Binding<Uicorn.View>, resolver r: Resolve? = nil) {
        _model = v
        resolver = r
    }
    var body: some View {
        content
            .sheet(isPresented: $shouldShowSheet) {
                sheetView?
                    .frame(minWidth: 300, minHeight: 300)
            }
            .onTapGesture {
                guard let a = model.action else { return }
                switch a.actionType {
                case .presentSelf:
                    sheetView = AnyView(content)
                    shouldShowSheet = true
                }
            }
    }
}

extension UicornView: UicornHost {
    func resolve(_ s: String, context c: ResolveContext) -> String {
        resolver?(s, shouldShowSheet ? .sheet : .`default`) ?? s
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
        binding {
            print($0)
        }
    }
    func binding(set: @escaping (Self)->()) -> Binding<Self> {
        .init(
            get: {
                self
            },
            set: set
        )
    }
}
