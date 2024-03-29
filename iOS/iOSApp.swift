//
//  iOSApp.swift
//  iOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import SwiftUI
import Combine

class DatabaseTreeViewState: ObservableObject {
    class Item: ObservableObject {
        @Published var app: Uicorn.App
        @Published var color: Color
        init(_ a: Uicorn.App, _ c: Color = .systemRandom) {
            app = a
            color = c
        }
    }
    let storage: AppStoring
    init(_ s: AppStoring = AppStorageCoreData()) {
        storage = s
    }
    @Published var items: [Item] = []
    func add(_ a: Uicorn.App) {
        storage.store(a)
        load()
    }
    func load() {
        items = storage.fetchApps().map { .init($0) }
        objectWillChange.send()
    }
}

@main
struct iOSApp: App {
    @StateObject private var backendController = BackendController(configuration: .live)
    @StateObject private var databaseController = DatabaseController(configuration: .mock)
    @StateObject private var componentController = ComponentController()
    private let pasteboard: UIPasteboard = .general
    private let spacing = 12.0
    private let cols = 3
    private let columns: [GridItem]
    @ObservedObject private var model: DatabaseTreeViewState = .init()
    @State private var isSheetPresented = false
    @State private var activeItem: DatabaseTreeViewState.Item?
    init() {
        columns = .init(repeating: .init(.flexible(), spacing: spacing), count: cols)
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                GeometryReader { geo in
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach($model.items, id: \.app.id) { $item in
                                VStack {
                                    $item.wrappedValue.color
                                        .frame(itemSize(forTotalSize: geo.size))
                                        .cornerRadius(15)
                                    Text($item.wrappedValue.app.title)
                                        .lineLimit(1)
                                }
                                .id($item.wrappedValue.app.id) // TODO: This is not updated on pasteboard fetch
                                .onTapGesture {
                                    activeItem = $item.wrappedValue
                                }
                            }
                        }
                        .padding(16)
                    }
                }
                .navigationTitle("Uicorn 🦄")
            }
            .navigationViewStyle(.stack)
            .navigationBarAppearance(.cyan)
            .onAppear {
                model.load()
            }
            .onReceive(pasteboard.changedPublisher) { hasStrings in
                guard
                    let d = pasteboard.data(forPasteboardType: .pasteboardIdUicornApp),
                    let a = try? JSONDecoder().decode(Uicorn.App.self, from: d)
                else {
                    return
                }
                pasteboard.items = []
                model.add(a)
            }
            .onChange(of: activeItem) { _ in
                isSheetPresented.toggle()
            }
            .fullScreenCover(isPresented: $isSheetPresented) {
                NavigationView {
                    ZStack {
                        if let $i = Binding($activeItem) {
                            VStack(spacing: 0) {
                                HStack {
                                    if let $v = $i.app.screens.first?.view, let b = Binding($v) {
                                        UicornView(b)
                                            .onAppear {
                                                componentController.app = $i.app
                                            }
                                            .environmentObject(backendController)
                                            .environmentObject(databaseController)
                                            .environmentObject(componentController)
                                            .environmentObject(EmptyValueProvider())
                                            .id(UUID())
                                    }
                                }
                                .layoutPriority(1)
                            }
                            .navigationBarAppearance($i.wrappedValue.color)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button {
                                        activeItem = nil
                                    } label: {
                                        Label("Close", systemImage: "")
                                            .foregroundColor(.white)
                                            .labelStyle(.titleOnly)
                                    }
                                }
                                ToolbarItem(placement: .principal) {
                                    Text($i.wrappedValue.app.title)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                }
                .navigationViewStyle(.stack)
            }
        }
    }
    private func itemSize(forTotalSize size: CGSize) -> CGSize {
        let s = .init(cols - 1) * spacing
        let v = max(0, (size.width / .init(cols)) - s)
        return .init(width: v, height: v)
    }
    private func clearActiveItem() {
        activeItem = nil
    }
}

extension DatabaseTreeViewState.Item: Equatable {
    static func == (lhs: DatabaseTreeViewState.Item, rhs: DatabaseTreeViewState.Item) -> Bool {
        lhs.app.id == rhs.app.id
    }
}

extension Uicorn.View: Equatable {
    static func == (lhs: Uicorn.View, rhs: Uicorn.View) -> Bool {
        lhs.id == rhs.id
    }
}

private extension SwiftUI.View {
    func frame(_ s: CGSize) -> some View {
        frame(width: s.width, height: s.height)
    }
}

extension UIPasteboard {
    var changedPublisher: AnyPublisher<Bool, Never> {
        return Just(hasStrings)
            .merge(
                with: NotificationCenter
                    .default
                    .publisher(for: UIPasteboard.changedNotification, object: self)
                    .map { _ in self.containsUicornApp }
            )
            .merge(
                with: NotificationCenter
                    .default
                    .publisher(for: UIApplication.didBecomeActiveNotification, object: nil)
                    .map { _ in self.containsUicornApp }
            )
            .eraseToAnyPublisher()
    }
    var containsUicornApp: Bool {
        contains(pasteboardTypes: [.pasteboardIdUicornApp])
    }
}

struct NavigationBarAppearanceModifier: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .onAppear {
                UINavigationBar.setupAppearance(.init(color))
            }
    }
}

extension View {
    func navigationBarAppearance(_ color: Color) -> some View {
        modifier(NavigationBarAppearanceModifier(color: color))
    }
}
