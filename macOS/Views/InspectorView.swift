//
//  InspectorView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct InspectorView: View {
    @EnvironmentObject private var observer: AppModelObserver
    @State private var v: Uicorn.View = .empty
    var body: some View {
        Form {
            // Specific properties
            switch v.type {
            case let .collection(c):
                CollectionPropertiesView(c.binding(set: observer.update))
            case let .shape(s):
                ShapePropertiesView(s.binding(set: observer.update))
            case let .text(t):
                TextPropertiesView(t.binding(set: observer.update))
            case let .image(i):
                ImagePropertiesView(i.binding(set: observer.update))
            case .vstack, .hstack, .zstack:
                StackPropertiesView(v.type.binding(set: observer.update))
//            case let .map(m):
//                MapPropertiesView(m.binding(set: observer.update))
            case let .scroll(s):
                ScrollPropertiesView(s.binding(set: observer.update))
            case let .instance(i):
                InstancePropertiesView(i.binding(set: observer.update))
            case let .color(c):
                ColorPropertiesView(header: "Type", model: c.binding(set: observer.update))
            case .empty, .spacer, .map:
                EmptyView()
            }
            // modifiers
            switch v.type {
            case .shape, .text, .image, .hstack, .vstack, .zstack, .scroll, .color:
                Divider()
                ModifiersView(v.safeModifiers.binding(set: observer.update))
            case .spacer, .empty, .instance, .map, .collection:
                EmptyView()
            }
        }
        .onChange(of: observer.sanitizedSelectedItem.id) { _ in
            v = observer.sanitizedSelectedItem.wrappedValue
        }
        .id(v.id)
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
