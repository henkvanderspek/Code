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
//                StackPropertiesView(Stack(s.binding(set: update)).binding(set: update))
                HStackPropertiesView(s.binding(set: update))
            case let .vstack(s):
//                StackPropertiesView(Stack(s.binding(set: update)).binding(set: update))
                VStackPropertiesView(s.binding(set: update))
            case let .zstack(s):
//                StackPropertiesView(Stack(s.binding(set: update)).binding(set: update))
                ZStackPropertiesView(s.binding(set: update))
            case .empty, .spacer, .map:
                EmptyView()
            }
            // Generic properties
            switch view.type {
            case .shape, .text, .image, .hstack, .vstack, .zstack:
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
            case .spacer, .empty, .collection, .map:
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
    func update(_ a: Stack) {
        switch a.axis {
        case .horizontal:
            if let s = a.model as? Uicorn.View.HStack {
                update(s)
            } else {
                print("TODO: convert to HStack")
            }
        case .vertical:
            if let s = a.model as? Uicorn.View.VStack {
                update(s)
            } else {
                print("TODO: convert to VStack")
            }
        case .depth:
            if let s = a.model as? Uicorn.View.ZStack {
                update(s)
            } else {
                print("TODO: convert to zStack")
            }
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
}

struct InspectorView_Previews: PreviewProvider {
    static var previews: some View {
        InspectorView(view: .constant(.mock))
    }
}

extension Stack: UicornViewType {}
