//
//  JsonUI+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import SwiftUI

struct JsonUIView: SwiftUI.View {
    let view: JsonUI.View
    init(_ v: JsonUI.View) {
        view = v
    }
    var body: some View {
        createView()
            .padding(view.attributes.padding)
            .backgroundColor(view.attributes.backgroundColor)
            .foregroundColor(view.attributes.foregroundColor)
    }
}

extension JsonUI.View: Identifiable {}

private extension JsonUIView {
    func createView() -> some SwiftUI.View {
        switch view.type {
        case let .hstack(v):
            return AnyView(HStack(v.children))
        case let .vstack(v):
            return AnyView(VStack(v.children))
        case let .zstack(v):
            return AnyView(ZStack(v.children))
        case let .image(v):
            return AnyView(Image(v))
        case let .text(v):
            return AnyView(Text(v))
        case let .script(s):
            return AnyView(Script(s))
        case .rectangle:
            return AnyView(Rectangle())
        case .spacer:
            return AnyView(Spacer())
        case .empty:
            return AnyView(EmptyView())
        }
    }
}

struct JsonUIView_Previews: PreviewProvider {
    static var previews: some View {
        JsonUIView(
            .hstack([
                .vstack([
                    .text("🤓"),
                    .text("🤓"),
                    .text("🤓")
                ]),
                .text("🤓"),
                .vstack([
                    .text("🤓"),
                    .text("🤓"),
                    .text("🤓"),
                ]),
            ],
            attributes: .padding(.all(8)))
        )
    }
}
