//
//  iOSApp.swift
//  iOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import SwiftUI
import Combine

class DataModel: ObservableObject {
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
    @StateObject private var backendController = Backend.Controller(configuration: .live)
    private let pasteboard: UIPasteboard = .general
    private let spacing = 12.0
    private let cols = 3
    private let columns: [GridItem]
    @ObservedObject private var model: DataModel = .init()
    @State private var isSheetPresented = false
    @State private var activeItem: DataModel.Item?
    init() {
        columns = .init(repeating: .init(.flexible(), spacing: spacing), count: cols)
        //UINavigationBar.setupAppearance()
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
                                $i.wrappedValue.color
                                    .ignoresSafeArea()
                                HStack {
                                    if let $v = $i.app.screens.first?.view, let b = Binding($v) {
                                        UicornView(b)
                                            .environmentObject(backendController)
                                            .id(UUID())
                                    }
                                }
                                .layoutPriority(1)
                            }
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
                        } else {
                            VStack {
                                Text("😱")
                                    .font(.system(.largeTitle).weight(.black))
                                    .scaleEffect(5)
                                    .navigationBarTitle("Error")
                                Button {
                                    isSheetPresented.toggle()
                                } label: {
                                    Label("Close", systemImage: "")
                                        .labelStyle(.titleOnly)
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

extension DataModel.Item: Equatable {
    static func == (lhs: DataModel.Item, rhs: DataModel.Item) -> Bool {
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

extension UINavigationBar {
    static func setupAppearance() {
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white
        ]
        let a = UINavigationBarAppearance()
        a.backgroundColor = .systemCyan
        a.titleTextAttributes = attributes
        a.largeTitleTextAttributes = attributes
        appearance().standardAppearance = a
        appearance().compactAppearance = a
        appearance().scrollEdgeAppearance = a
    }
}
