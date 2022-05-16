//
//  AppView.swift
//  macOS
//
//  Created by Henk van der Spek on 03/05/2022.
//

import SwiftUI

struct AppView: View {
    class Observer: ObservableObject {
        init(_ a: Uicorn.App) {
            rootItem = a
            selectedItem = a
        }
        @Published var rootItem: TreeItem
        @Published var selectedItem: TreeItem
    }
    @ObservedObject private var observer: Observer
    init(_ a: Uicorn.App) {
        observer = .init(a)
    }
    var body: some View {
        NavigationView {
            List {
                TreeView($observer.rootItem, selectedItem: $observer.selectedItem) { item in
                    TreeItemMenu {
                        menuItems(item)
                    }
                    .isDisabled(!item.isView)
                    .tapGesture {
                        observer.selectedItem = item
                    }
                }
            }.listStyle(.sidebar)
            ScreenView(observer.sanitizedScreen)
            List {
                PropertiesView(view: observer.sanitizedSelectedItem)
                    .id(UUID())
            }.listStyle(.sidebar)
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
    private func menuItems(_ i: TreeItem) -> [TreeItemMenu.Item] {
        return [
            .init(title: "Embed in HStack") {
                guard let v = i as? Uicorn.View else { return }
                v.embeddedInHStack()
                observer.objectWillChange.send()
            }
        ]
    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        AppView(.mock)
    }
}

extension AppView.Observer {
    var sanitizedScreen: Binding<Uicorn.Screen> {
        let children = rootItem.safeChildren
        let child = children.first(where: { $0.contains(selectedItem) }) ?? children.first
        return .init(
            get: {
                return child as! Uicorn.Screen
            },
            set: {
                print($0)
            }
        )
    }
    var sanitizedSelectedItem: Binding<Uicorn.View> {
        return .init(
            get: {
                self.selectedItem as? Uicorn.View ?? .empty
            },
            set: {
                print($0)
                self.selectedItem = $0
            }
        )
    }
}

extension Uicorn.View {
    func embeddedInHStack() {
        type = .hstack(.init([.init(id: id, type: type, action: nil, properties: nil)], spacing: 0))
        id = UUID().uuidString
    }
}
