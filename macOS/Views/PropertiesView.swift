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
            case let .shape(s):
                ShapePropertiesView(
                    model: s.binding {
                        $view.type.wrappedValue = .shape($0)
                        $view.wrappedValue.id = UUID().uuidString
                    }
                )
            case .empty:
                EmptyView()
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
