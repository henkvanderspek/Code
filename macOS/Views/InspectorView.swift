//
//  InspectorView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct InspectorView: View {
    @EnvironmentObject private var appTreeViewState: AppTreeViewState
    @State private var v: Uicorn.View = .empty
    var body: some View {
        Form {
            // Specific properties
            switch v.type {
            case let .collection(c):
                CollectionPropertiesView(c.binding(set: appTreeViewState.update))
            case let .shape(s):
                ShapePropertiesView(s.binding(set: appTreeViewState.update))
            case let .text(t):
                TextPropertiesView(t.binding(set: appTreeViewState.update))
            case let .image(i):
                ImagePropertiesView(i.binding(set: appTreeViewState.update))
            case .vstack, .hstack, .zstack:
                StackPropertiesView(v.type.binding(set: appTreeViewState.update))
//            case let .map(m):
//                MapPropertiesView(m.binding(set: appTreeView.update))
            case let .scroll(s):
                ScrollPropertiesView(s.binding(set: appTreeViewState.update))
            case let .instance(i):
                InstancePropertiesView(i.binding(set: appTreeViewState.update))
            case let .color(c):
                ColorPropertiesView(header: "Type", model: c.binding(set: appTreeViewState.update))
            case .empty, .spacer, .map:
                EmptyView()
            }
            // modifiers
            switch v.type {
            case .shape, .text, .image, .hstack, .vstack, .zstack, .scroll, .color:
                Divider()
                ModifiersView(v.safeModifiers.binding(set: appTreeViewState.update))
            case .spacer, .empty, .instance, .map, .collection:
                EmptyView()
            }
        }
        .onChange(of: appTreeViewState.sanitizedSelectedItem.id) { _ in
            v = appTreeViewState.sanitizedSelectedItem.wrappedValue
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
