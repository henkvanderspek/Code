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
            rootItem = a
            selectedItem = a
        }
        @Published var rootItem: TreeItem
        @Published var selectedItem: TreeItem
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
            ScreenView(observer.sanitizedScreen)
            PropertiesView(view: observer.sanitizedSelectedItem)
        }
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
                        }
                    }
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
        }
    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        AppView(.mock)
    }
}

extension AppView.Observer {
    var sanitizedScreen: Binding<JsonUI.Screen> {
        let children = rootItem.safeChildren
        let child = children.first(where: { $0.contains(selectedItem) }) ?? children.first
        return .init(
            get: {
                return child as! JsonUI.Screen
            },
            set: {
                print($0)
            }
        )
    }
    var sanitizedSelectedItem: Binding<JsonUI.View> {
        .init(
            get: {
                self.selectedItem as? JsonUI.View ?? .empty
            },
            set: {
                print($0)
            }
        )
    }
}
