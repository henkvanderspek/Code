//
//  InspectorView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct InspectorView: View {
    @EnvironmentObject private var observer: AppView.Observer
    @State private var v: Uicorn.View = .empty
    @State private var child: Uicorn.View?
    var body: some View {
        Form {
            if child?.id != nil {
                Button {
                    child = nil
                } label: {
                    Text("Back")
                }
                .buttonStyle(.link)
                Divider()
            }
            // Specific properties
            switch subject.type {
            case let .collection(c):
                CollectionPropertiesView(c.binding(set: update))
            case let .shape(s):
                ShapePropertiesView(s.binding(set: update))
            case let .text(t):
                TextPropertiesView(t.binding(set: update))
            case let .image(i):
                ImagePropertiesView(i.binding(set: update))
            case .vstack, .hstack, .zstack:
                StackPropertiesView(subject.type.binding(set: update))
            case let .map(m):
                MapPropertiesView(m.binding(set: update))
            case let .scroll(s):
                ScrollPropertiesView(s.binding(set: update))
            case let .instance(i):
                InstancePropertiesView(i.binding(set: update))
            case let .color(c):
                ColorPropertiesView(header: "Type", model: c.binding(set: update))
            case .empty, .spacer:
                EmptyView()
            }
            // modifiers
            switch subject.type {
            case .shape, .text, .image, .hstack, .vstack, .zstack, .scroll, .collection, .map, .color:
                Divider()
                ModifiersView(subject.safeModifiers.binding(set: update), selectedChild: $child)
            case .spacer, .empty, .instance:
                EmptyView()
            }
        }
        .onChange(of: observer.sanitizedSelectedItem.id) { _ in
            v = observer.sanitizedSelectedItem.wrappedValue
            child = nil
        }
        .onChange(of: child?.id) { _ in
            guard let c = child else { return }
            observer.selectedItem = c
        }
    }
    private var subject: Uicorn.View {
        child ?? v
    }
}

private extension Uicorn.View {
    var safeModifiers: Modifiers {
        modifiers ?? .empty
    }
}

struct InspectorView_Previews: PreviewProvider {
    static var previews: some View {
        InspectorView()
    }
}

private extension InspectorView {
    func update(_ c: Bindable) {
        if let m = c as? Uicorn.View.Modifiers {
            subject.modifiers = m
        }
        observer.sendWillChange()
    }
}
