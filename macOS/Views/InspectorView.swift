//
//  InspectorView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct InspectorView: View {
    @Binding var view: Uicorn.View
    var body: some View {
        Form {
            // Specific properties
            switch view.type {
            case let .collection(c):
                CollectionPropertiesView(c.binding(set: update))
            case let .shape(s):
                ShapePropertiesView(s.binding(set: update))
            case let .text(t):
                TextPropertiesView(t.binding(set: update))
            case let .image(i):
                ImagePropertiesView(i.binding(set: update))
            case let .hstack(s):
                StackPropertiesView(
                    Stack(.horizontal).binding(
                        set: {
                            update($0, s)
                        }
                    ),
                    s.binding(set: update)
                )
            case let .vstack(s):
                StackPropertiesView(
                    Stack(.vertical).binding(
                        set: {
                            update($0, s)
                        }
                    ),
                    s.binding(set: update)
                )
            case let .zstack(s):
                StackPropertiesView(
                    Stack(.depth).binding(
                        set: {
                            update($0, s)
                        }
                    ),
                    s.binding(set: update)
                )
            case let .map(m):
                MapPropertiesView(m.binding(set: update))
            case let .scroll(s):
                ScrollPropertiesView(s.binding(set: update))
            case let .instance(i):
                InstancePropertiesView(i.binding(set: update))
            case .empty, .spacer:
                EmptyView()
            }
            // Generic properties
            switch view.type {
            case .shape, .text, .image, .hstack, .vstack, .zstack, .scroll, .collection, .map:
                Divider()
                PropertiesView(
                    .init(
                        get: {
                            view.properties ?? .empty
                        },
                        set: {
                            $view.properties.wrappedValue = $0
                        }
                    )
                )
            case .spacer, .empty, .instance:
                EmptyView()
            }
        }
        .id(view.id)
    }
}

private extension InspectorView {
    func update(_ c: Uicorn.View.Collection) {
        $view.type.wrappedValue = .collection(c)
    }
    func update(_ s: Uicorn.View.Shape) {
        $view.type.wrappedValue = .shape(s)
    }
    func update(_ t: Uicorn.View.Text) {
        $view.type.wrappedValue = .text(t)
    }
    func update(_ i: Uicorn.View.Image) {
        $view.type.wrappedValue = .image(i)
    }
    func update(_ s: Stack, _ v: Uicorn.View.HStack) {
        switch s.axis {
        case .vertical:
            update(Uicorn.View.VStack(v.children, alignment: .init(v.alignment), spacing: v.spacing))
        case .depth:
            update(Uicorn.View.ZStack(v.children, alignment: .init(v.alignment)))
        case .horizontal: ()
        }
    }
    func update(_ s: Stack, _ v: Uicorn.View.VStack) {
        switch s.axis {
        case .horizontal:
            update(Uicorn.View.HStack(v.children, alignment: .init(v.alignment), spacing: v.spacing))
        case .depth:
            update(Uicorn.View.ZStack(v.children, alignment: .init(v.alignment)))
        case .vertical: ()
        }
    }
    func update(_ s: Stack, _ v: Uicorn.View.ZStack) {
        switch s.axis {
        case .horizontal:
            update(Uicorn.View.HStack(v.children, alignment: .init(v.alignment), spacing: 0))
        case .vertical:
            update(Uicorn.View.VStack(v.children, alignment: .init(v.alignment), spacing: 0))
        case .depth: ()
        }
    }
    func update(_ s: Uicorn.View.HStack) {
        $view.type.wrappedValue = .hstack(s)
    }
    func update(_ s: Uicorn.View.VStack) {
        $view.type.wrappedValue = .vstack(s)
    }
    func update(_ s: Uicorn.View.ZStack) {
        $view.type.wrappedValue = .zstack(s)
    }
    func update(_ m: Uicorn.View.Map) {
        $view.type.wrappedValue = .map(m)
    }
    func update(_ s: Uicorn.View.Scroll) {
        $view.type.wrappedValue = .scroll(s)
    }
    func update(_ i: Uicorn.View.Instance) {
        $view.type.wrappedValue = .instance(i)
    }
}

struct InspectorView_Previews: PreviewProvider {
    static var previews: some View {
        InspectorView(view: .constant(.mock))
    }
}

extension Stack: UicornViewType {}

extension Uicorn.VerticalAlignment {
    init(_ a: Uicorn.HorizontalAlignment) {
        switch a {
        case .leading: self = .top
        case .center: self = .center
        case .trailing: self = .bottom
        }
    }
}

extension Uicorn.HorizontalAlignment {
    init(_ a: Uicorn.VerticalAlignment) {
        switch a {
        case .top: self = .leading
        case .bottom: self = .trailing
        case .center: fallthrough
        default: self = .center
        }
    }
}

extension Uicorn.HorizontalAlignment {
    init(_ a: Uicorn.Alignment) {
        switch a {
        case .topLeading, .top, .topTrailing:
            self = .leading
        case .leading, .center, .trailing:
            self = .center
        case .bottomLeading, .bottom, .bottomTrailing:
            self = .trailing
        }
    }
}

extension Uicorn.VerticalAlignment {
    init(_ a: Uicorn.Alignment) {
        switch a {
        case .topLeading, .top, .topTrailing:
            self = .top
        case .leading, .center, .trailing:
            self = .center
        case .bottomLeading, .bottom, .bottomTrailing:
            self = .bottom
        }
    }
}

extension Uicorn.Alignment {
    init(_ a: Uicorn.VerticalAlignment) {
        switch a {
        case .top: self = .leading
        case .bottom: self = .trailing
        case .center: fallthrough
        default: self = .center
        }
    }
}

extension Uicorn.Alignment {
    init(_ a: Uicorn.HorizontalAlignment) {
        switch a {
        case .leading: self = .leading
        case .trailing: self = .trailing
        case .center: self = .center
        }
    }
}
