//
//  AppView.swift
//  macOS
//
//  Created by Henk van der Spek on 03/05/2022.
//

import SwiftUI

struct AppView: View {
    class Observer: ObservableObject {
        init(_ a: JsonUI.App) {
            let i = a.appItem
            rootItem = i
            selectedItem = i
        }
        @Published var rootItem: AppItem
        @Published var selectedItem: AppItem
    }
    @ObservedObject private var observer: Observer
    init(_ a: JsonUI.App) {
        observer = .init(a)
    }
    var body: some View {
        NavigationView {
            List {
                TreeView($observer.rootItem, selectedItem: $observer.selectedItem)
            }
            .listStyle(.sidebar)
            ScreenView($observer.selectedItem.screen)
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
                                }.disabled(observer.selectedItem.screen == nil)
                            }
                        } label: {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
            PropertiesView(view: $observer.selectedItem.view)
        }
    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        AppView(.mock)
    }
}
