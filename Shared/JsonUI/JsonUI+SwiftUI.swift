//
//  JsonUI+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import SwiftUI
import MapKit

struct JsonUIView: SwiftUI.View {
    let view: JsonUI.View
    init(_ v: JsonUI.View) {
        view = v
    }
    var body: some View {
        content
            .padding(view.attributes.padding)
            .backgroundColor(view.attributes.backgroundColor)
            .foregroundColor(view.attributes.foregroundColor)
    }
}

extension JsonUI.Screen: Identifiable {}
extension JsonUI.View: Identifiable {}

private extension JsonUIView {
    @ViewBuilder var content: some SwiftUI.View {
        switch view.type {
        case let .hstack(v):
            HStack(v.children)
        case let .vstack(v):
            VStack(v.children)
        case let .zstack(v):
            ZStack(v.children)
        case let .image(v):
            Image(v)
        case let .text(v):
            Text(v)
        case let .script(s):
            Script(s)
        case .rectangle:
            Rectangle()
        case .spacer:
            Spacer()
        case let .map(m):
            MapView(m)
        case .empty:
            EmptyView()
        }
    }
}

struct JsonUIView_Previews: PreviewProvider {
    static var previews: some View {
        JsonUIView(.mock)
    }
}
