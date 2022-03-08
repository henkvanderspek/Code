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
            .padding(view.padding)
    }
}

extension JsonUI.View.Padding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.leading, leading.map { .init($0) } ?? 0)
            .padding(.trailing, trailing.map { .init($0) } ?? 0)
            .padding(.top, top.map { .init($0) } ?? 0)
            .padding(.bottom, bottom.map { .init($0) } ?? 0)
    }
}

extension JsonUI.View.Padding {
    static var zero: Self {
        .init(leading: nil, trailing: nil, top: nil, bottom: nil)
    }
    static func all(_ v: Int) -> Self {
        .init(leading: v, trailing: v, top: v, bottom: v)
    }
}

extension View {
    func padding(_ p: JsonUI.View.Padding?) -> some View {
        guard let p = p else { return AnyView(self) }
        return AnyView(modifier(p))
    }
}

private extension JsonUIView {
    func createView() -> some SwiftUI.View {
        switch view.type {
        case let .hstack(v):
            return AnyView(HStack(v))
        case let .vstack(v):
            return AnyView(VStack(v))
        case let .zstack(v):
            return AnyView(ZStack(v))
        case let .image(v):
            return AnyView(Image(v))
        case let .text(v):
            return AnyView(Text(v))
        case let .script(s):
            return AnyView(Script(s))
        case .empty:
            return AnyView(EmptyView())
        }
    }
}

extension JsonUI.View: Identifiable {}

extension JsonUIView {
    struct HStack: View {
        let view: JsonUI.View.HStack
        init(_ v: JsonUI.View.HStack) {
            view = v
        }
        var body: some View {
            SwiftUI.HStack {
                ForEach(view.children) {
                    JsonUIView($0)
                }
            }
        }
    }

    struct VStack: View {
        let id = UUID()
        let view: JsonUI.View.VStack
        init(_ v: JsonUI.View.VStack) {
            view = v
        }
        var body: some View {
            SwiftUI.VStack {
                ForEach(view.children) {
                    JsonUIView($0)
                }
            }
        }
    }

    struct ZStack: View {
        let id = UUID()
        let view: JsonUI.View.ZStack
        init(_ v: JsonUI.View.ZStack) {
            view = v
        }
        var body: some View {
            SwiftUI.ZStack {
                
            }
        }
    }

    struct Image: View {
        let id = UUID()
        let view: JsonUI.View.Image
        init(_ v: JsonUI.View.Image) {
            view = v
        }
        var body: some View {
            SwiftUI.Image(systemName: "mustache.fill")
        }
    }

    struct Text: View {
        let id = UUID()
        let view: JsonUI.View.Text
        init(_ v: JsonUI.View.Text) {
            view = v
        }
        var body: some View {
            SwiftUI.Text(view.value)
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
            ], padding: .all(8))
        )
    }
}
