//
//  AppView.swift
//  macOS
//
//  Created by Henk van der Spek on 03/05/2022.
//

import SwiftUI

struct AppView: View {
    @ObservedObject private var appObserver: AppModelObserver
    @ObservedObject private var databaseObserver: DatabaseModelObserver
    @State var shouldShowDarkMode: Bool = false
    private let storage: AppStoring?
    private let pasteboard: NSPasteboard = .general
    @StateObject private var componentController = ComponentController()
    @State private var isDatabaseActive: Bool = false
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    init(_ a: Uicorn.App, storage s: AppStoring? = nil, databaseController db: DatabaseController) {
        appObserver = .init(a)
        // TODO: We need this in the constructor because the state object can't be instantiated later somehow
        databaseObserver = .init(db)
        storage = s
    }
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List {
                if isDatabaseActive {
                    TreeView($databaseObserver.rootItem, selectedItem: $databaseObserver.selectedItem) { view in
                        TreeItemMenu {
                            menuItems(view.item, parent: view.parent)
                        }
                        .isDisabled(!view.item.isView)
                        .tapGesture {
                            databaseObserver.selectItem(&view.item)
                        }
                        .id(UUID())
                    }
                } else {
                    TreeView($appObserver.rootItem, selectedItem: $appObserver.selectedItem) { view in
                        TreeItemMenu {
                            menuItems(view.item, parent: view.parent)
                        }
                        .isDisabled(!view.item.isView)
                        .tapGesture {
                            appObserver.selectItem(&view.item)
                        }
                        .id(UUID())
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationSplitViewColumnWidth(min: 200, ideal: 250)
        } content: {
            if isDatabaseActive {
                DatabaseView()
            } else if let b = Binding($appObserver.sanitizedScreen) {
                AppearanceView(colorScheme: shouldShowDarkMode ? .dark : .light) {
                    ScreenView(b)
                }
                .navigationSplitViewColumnWidth(min: 400, ideal: 450)
                .id($appObserver.sanitizedScreen.wrappedValue?.view?.id ?? "empty")
                .toolbar {
                    ToolbarItemGroup(placement: .navigation) {
                        Menu {
                            ForEach(ViewType.sanitizedCases, id: \.self) { type in
                                Button {
                                    appObserver.addView(ofType: type)
                                } label: {
                                    Label(type.name, systemImage: type.systemImage)
                                        .labelStyle(.titleAndIcon)
                                }
                            }
                        } label: {
                            Label("Add", systemImage: "plus")
                                .labelStyle(.iconOnly)
                        }
                        .disabled(!appObserver.selectedItem.canAddView)
                        Toggle(isOn: $shouldShowDarkMode) {
                            Label("Toggle Appearance", systemImage: shouldShowDarkMode ? "moon.fill" : "sun.max.fill")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
            }
        } detail: {
            List {
                if isDatabaseActive {
                   EmptyView()
                } else {
                    InspectorView()
                }
            }.listStyle(.sidebar)
        }
        .environmentObject(componentController)
        .environmentObject(EmptyValueProvider())
        .environmentObject(appObserver)
        .environmentObject(databaseObserver)
        .navigationViewStyle(.columns)
        .navigationTitle("")
        .toolbar {
            ToolbarItem {
                Toggle(isOn: $isDatabaseActive) {
                    Label("Database", systemImage: "opticaldiscdrive")
                        .labelStyle(.iconOnly)
                }
            }
        }
        .onReceive(appObserver.objectWillChange.first()) {
            guard let a = appObserver.rootItem as? Uicorn.App else { return }
            storage?.store(a) {
                pasteboard.declareTypes([.uicornApp], owner: nil)
                pasteboard.setData($0, forType: .uicornApp)
                //print(String(data: $0 ?? .init(), encoding: .utf8))
            }
        }
        .onAppear {
            componentController.app = $appObserver.app
        }
    }
    private func menuItems(_ i: TreeItem, parent: Binding<TreeItem>?) -> [TreeItemMenu.Item] {
        return [
            .init(title: "Embed in HStack", image: .init(.hstack)) {
                appObserver.embedInHStack(i)
            },
            .init(title: "Embed in VStack", image: .init(.vstack)) {
                appObserver.embedInVStack(i)
            },
            .init(title: "Embed in ZStack", image: .init(.zstack)) {
                appObserver.embedInZStack(i)
            },
            .init(title: "Delete", image: .init("trash")) {
                appObserver.delete(i, from: parent!)
            },
            .init(title: i.isHidden ? "Show" : "Hide", image: .init(i.isHidden ? "eye" : "eye.slash")) {
                appObserver.toggleVisibility()
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
        AppView(.mock, databaseController: .init(configuration: .dev))
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
            return .database
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
