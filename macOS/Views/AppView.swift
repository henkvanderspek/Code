//
//  AppView.swift
//  macOS
//
//  Created by Henk van der Spek on 03/05/2022.
//

import SwiftUI

struct AppView: View {
    @Binding var app: JsonUI.App
    @State private var rootItem: AppItem
    @State private var selectedItem: AppItem
    init(_ a: Binding<JsonUI.App>) {
        _app = a
        _rootItem = .init(initialValue: a.wrappedValue.appItem)
        _selectedItem = _rootItem
    }
    var body: some View {
        NavigationView {
            List {
                TreeView($rootItem, selectedItem: $selectedItem)
            }
            .listStyle(.sidebar)
            ScreenView($selectedItem.screen)
                .navigationViewStyle(.columns)
                .navigationTitle("")
                .toolbar {
                    ToolbarItemGroup(placement: .navigation) {
                        Menu {
                            ForEach(ViewType.allCases, id: \.self) { type in
                                Button {
                                    print(type.name)
                                } label: {
                                    Label(type.name, systemImage: type.systemImage)
                                        .labelStyle(.titleAndIcon)
                                }.disabled(selectedItem.screen == nil)
                            }
                        } label: {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
            PropertiesView(
                view: .init(
                    get: {
                        selectedItem.view
                    },
                    set: {
                        selectedItem.view = $0
                    }
                )
            )
        }
    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        AppView(.constant(.mock))
    }
}
