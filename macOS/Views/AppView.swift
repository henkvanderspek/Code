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
            app = a
            rootItem = a
            selectedItem = a
        }
        @Published var app: Uicorn.App // TODO: use rootItem
        @Published var rootItem: TreeItem
        @Published var selectedItem: TreeItem
    }
    @ObservedObject private var observer: Observer
    @State var shouldShowDarkMode: Bool = false
    private let storage: AppStoring?
    private let pasteboard: NSPasteboard = .general
    @StateObject private var componentController = ComponentController()
    @State private var isCmsActive: Bool = false
    init(_ a: Uicorn.App, storage s: AppStoring? = nil) {
        observer = .init(a)
        storage = s
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
                        // TODO: Possible cause for occasional crash
                        observer.selectedItem.isSelected = false
                        view.item.isSelected = true
                        observer.selectedItem = view.item
                    }
                    .id(UUID())
                }
                .isHidden(isCmsActive)
            }.listStyle(.sidebar)

            if isCmsActive {
                CmsView()
            } else if let b = Binding($observer.sanitizedScreen) {
                AppearanceView(colorScheme: shouldShowDarkMode ? .dark : .light) {
                    ScreenView(b)
                }
                .id($observer.sanitizedScreen.wrappedValue?.view?.id ?? "empty")
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
                                .labelStyle(.iconOnly)
                        }
                        .disabled(!observer.selectedItem.canAddView)
                        Toggle(isOn: $shouldShowDarkMode) {
                            Label("Toggle Appearance", systemImage: shouldShowDarkMode ? "moon.fill" : "sun.max.fill")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
            }
            List {
                if isCmsActive {
                   EmptyView()
                } else {
                    InspectorView()
                }
            }.listStyle(.sidebar)
        }
        .environmentObject(componentController)
        .environmentObject(EmptyValueProvider())
        .environmentObject(observer)
        .navigationViewStyle(.columns)
        .navigationTitle("")
        .toolbar {
            ToolbarItem {
                Toggle(isOn: $isCmsActive) {
                    Label("CMS", systemImage: "opticaldiscdrive")
                        .labelStyle(.iconOnly)
                }
            }
        }
        .onReceive(observer.objectWillChange.first()) {
            guard let a = observer.rootItem as? Uicorn.App else { return }
            storage?.store(a) {
                pasteboard.declareTypes([.uicornApp], owner: nil)
                pasteboard.setData($0, forType: .uicornApp)
                //print(String(data: $0 ?? .init(), encoding: .utf8))
            }
        }
        .onAppear {
            componentController.app = $observer.app
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
            },
            .init(title: i.isHidden ? "Show" : "Hide", image: .init(i.isHidden ? "eye" : "eye.slash")) {
                observer.toggleVisibility()
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

struct App_Previews: PreviewProvider {
    static var previews: some View {
        AppView(.mock)
    }
}

extension TreeItem {
    func screen(by id: String) -> TreeItem? {
        guard !(self is Uicorn.App) else { return (self as? Uicorn.App)?.screens.first }
        guard id != self.id else { return self }
        guard let c = children else { return nil }
        return c.first(where: { $0.id == id || $0.contains(id) })
    }
}

extension AppView.Observer {
    var sanitizedScreen: Uicorn.Screen? {
        get {
            rootItem.screen(by: selectedItem.id) as? Uicorn.Screen
        }
        set {
            fatalError()
        }
    }
    var sanitizedSelectedItem: Binding<Uicorn.View> {
        return .init(
            get: {
                if self.selectedItem.isView {
                    return self.selectedItem.view ?? .empty
                } else {
                    return .empty
                }
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
    func toggleVisibility() {
        guard let h = selectedItem.view?.isHidden else { return }
        selectedItem.view?.isHidden = !h
        objectWillChange.send()
    }
    func addView(ofType t: ViewType) {
        selectedItem.addView(.from(t))
        selectedItem = selectedItem.children?.last ?? selectedItem
        objectWillChange.send()
    }
    // TODO: Do we still need these?
    func update(_ t: Uicorn.View.`Type`) {
        selectedItem.view?.type = t
        sendWillChange()
    }
    func update(_ c: Uicorn.View.Collection) {
        update(.collection(c))
    }
    func update(_ s: Uicorn.View.Shape) {
        update(.shape(s))
    }
    func update(_ t: Uicorn.View.Text) {
        update(.text(t))
    }
    func update(_ i: Uicorn.View.Image) {
        update(.image(i))
    }
    func update(_ m: Uicorn.View.Map) {
        update(.map(m))
    }
    func update(_ s: Uicorn.View.Scroll) {
        update(.scroll(s))
    }
    func update(_ i: Uicorn.View.Instance) {
        update(.instance(i))
    }
    func update(_ c: Uicorn.Color) {
        update(.color(c))
    }
    func update(_ m: Uicorn.View.Modifiers) {
        selectedItem.view?.modifiers = m
        sendWillChange()
    }
    func sendWillChange() {
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
        case .instance:
            return .postInstance
        case .color:
            return .color
        default:
            fatalError()
        }
    }
}
