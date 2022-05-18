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
            switch view.type {
            case let .collection(c):
                CollectionPropertiesView(
                    model: c.binding {
                        $view.type.wrappedValue = .collection($0)
                        $view.wrappedValue.id = UUID().uuidString
                    }
                )
            case let .shape(s):
                ShapePropertiesView(
                    model: s.binding {
                        $view.type.wrappedValue = .shape($0)
                        $view.wrappedValue.id = UUID().uuidString
                    }
                )
            case let .text(t):
                TextPropertiesView(
                    model: t.binding {
                        $view.type.wrappedValue = .text($0)
                        $view.wrappedValue.id = UUID().uuidString
                    }
                )
            case .empty, .image, .hstack, .vstack, .zstack, .spacer:
                EmptyView()
            }
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
            case .spacer, .empty, .collection:
                EmptyView()
            }
        }
    }
}

struct InspectorView_Previews: PreviewProvider {
    static var previews: some View {
        InspectorView(view: .constant(.mock))
    }
}
