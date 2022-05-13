//
//  PropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct PropertiesView: View {
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
            case .empty:
                EmptyView()
            case let .rectangle(r):
                ColorPropertiesView(
                    header: "Color",
                    r.fill.binding {
                        $view.type.wrappedValue = .rectangle(.init(fill: $0))
                        $view.wrappedValue.id = UUID().uuidString
                    }
                )
            case let .color(c):
                ColorPropertiesView(
                    header: "Color",
                    c.binding {
                        $view.type.wrappedValue = .color($0)
                        $view.wrappedValue.id = UUID().uuidString
                    }
                )
            default:
                Section {
                    Header(view.title)
                }.labelsHidden()
            }
        }
    }
}

struct PropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesView(view: .constant(.mock))
    }
}
