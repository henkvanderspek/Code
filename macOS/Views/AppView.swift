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
    @State var shouldShowDarkMode: Bool = false
    init(_ a: Uicorn.App) {
        observer = .init(a)
    }
    var body: some View {
        NavigationView {
            List {
                TreeView($observer.rootItem, selectedItem: $observer.selectedItem) { view in
                    TreeItemMenu {
                        menuItems(view.item, parent: view.parent)
                    }
                    .isDisabled(!view.item.isView)
                    .tapGesture {
                        observer.selectedItem = view.item
                    }
                }
            }.listStyle(.sidebar)
            AppearanceView(colorScheme: shouldShowDarkMode ? .dark : .light) {
                ScreenView(observer.sanitizedScreen)
            }.id(UUID())
            List {
                InspectorView(view: observer.sanitizedSelectedItem)
            }.listStyle(.sidebar)
        }
        .navigationViewStyle(.columns)
        .navigationTitle("")
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Menu {
                    ForEach(ViewType.sanitizedCases, id: \.self) { type in
                        Button {
                            observer.addView(ofType: type)
                        } label: {
                            Label(type.name, systemImage: type.systemImage)
                                .labelStyle(.titleAndIcon)
                        }
                    }
                } label: {
                    Label("Add", systemImage: "plus")
                }
                .disabled(!observer.selectedItem.canAddView)
                Toggle(isOn: $shouldShowDarkMode) {
                    Label("Toggle Appearance", systemImage: shouldShowDarkMode ? "moon.fill" : "sun.max.fill")
                        .labelStyle(.iconOnly)
                }
            }
        }
    }
    private func menuItems(_ i: TreeItem, parent: Binding<TreeItem>?) -> [TreeItemMenu.Item] {
        return [
            .init(title: "Embed in HStack", image: .init(.hstack)) {
                observer.embedInHStack(i)
            },
            .init(title: "Embed in VStack", image: .init(.vstack)) {
                observer.embedInVStack(i)
            },
            .init(title: "Embed in ZStack", image: .init(.zstack)) {
                observer.embedInZStack(i)
            },
            .init(title: "Delete", image: .init("trash")) {
                observer.delete(i, from: parent!)
            }
        ]
    }
}

extension NSImage {
    convenience init?(_ s: String) {
        self.init(systemSymbolName: s, accessibilityDescription: nil)
    }
    convenience init?(_ t: ViewType) {
        self.init(systemSymbolName: t.systemImage, accessibilityDescription: nil)
    }
}

extension TreeItem {
    var view: Uicorn.View? {
        self as? Uicorn.View
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
                self.selectedItem = $0
            }
        )
    }
    func embedInHStack(_ i: TreeItem) {
        i.view?.embeddedInHStack()
        objectWillChange.send()
    }
    func embedInVStack(_ i: TreeItem) {
        i.view?.embeddedInVStack()
        objectWillChange.send()
    }
    func embedInZStack(_ i: TreeItem) {
        i.view?.embeddedInZStack()
        objectWillChange.send()
    }
    func delete(_ i: TreeItem, from parent: Binding<TreeItem>) {
        var p = parent.wrappedValue
        p.removeChild(byId: i.id)
        selectedItem = p
        objectWillChange.send()
    }
    func addView(ofType t: ViewType) {
        selectedItem.addView(.from(t))
        selectedItem = selectedItem.children?.last ?? selectedItem
        objectWillChange.send()
    }
}

extension TreeItem {
    mutating func addView(_ v: Uicorn.View) {
        var c = children ?? []
        c.append(v)
        children = c
    }
}

extension Uicorn.View {
    func embeddedInHStack() {
        modified(type: .hstack(.init([cloned()], spacing: 0)))
    }
    func embeddedInVStack() {
        modified(type: .vstack(.init([cloned()], spacing: 0)))
    }
    func embeddedInZStack() {
        modified(type: .zstack(.init([cloned()])))
    }
    func cloned() -> Uicorn.View {
        .init(id: id, type: type, action: action, properties: properties)
    }
    func modified(type t: Uicorn.View.`Type`) {
        id = UUID().uuidString
        type = t
        properties = nil
        action = nil
    }
}

extension Uicorn.View {
    static func from(_ t: ViewType) -> Uicorn.View {
        switch t {
        case .text:
            return .text("Text")
        case .spacer:
            return .spacer
        case .sfSymbol:
            return .randomSystemImage
        case .image:
            return .randomRemoteImage
        case .hstack:
            return .hstack
        case .vstack:
            return .vstack
        case .zstack:
            return .zstack
        case .map:
            return .map
        case .shape:
            return .rectangle
        case .collection:
            return .unsplash
        case .vscroll:
            return .vscroll
        case .hscroll:
            return .hscroll
        default:
            fatalError()
        }
    }
}
