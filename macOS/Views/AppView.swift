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
            set: { _ in }
        )
    }
    var sanitizedSelectedItem: Binding<JsonUI.View> {
        return .init(
            get: {
                self.selectedItem as? JsonUI.View ?? .empty
            },
            set: {
                self.selectedItem = $0
                self.rootItem = self.rootItem.updated($0)
            }
        )
    }
}

private extension TreeItem {
    func updated(_ v: JsonUI.View) -> TreeItem {
        if let a = self as? JsonUI.App {
            return a.updated(v)
        } else if let s = self as? JsonUI.Screen {
            return s.updated(v)
        } else if let v = self as? JsonUI.View {
            return v.updated(v)
        }
        return self
    }
}

private extension JsonUI.View {
    func updated(_ v: JsonUI.View) -> Self {
        var ret = self
        if id == v.id {
            ret.type = v.type
        } else {
            ret.children = safeChildren.updated(v)
        }
        return ret
    }
}

private extension JsonUI.Screen {
    func updated(_ v: JsonUI.View) -> Self {
        var ret = self
        ret.view = view.updated(v)
        return ret
    }
}

private extension JsonUI.App {
    func updated(_ v: JsonUI.View) -> Self {
        var ret = self
        ret.screens = screens.updated(v)
        return ret
    }
}

private extension Array where Element == TreeItem {
    func updated(_ v: JsonUI.View) -> Self {
        map { $0.updated(v) }
    }
}

private extension Array where Element == JsonUI.Screen {
    func updated(_ v: JsonUI.View) -> Self {
        map { $0.updated(v) }
    }
}
