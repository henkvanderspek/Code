//
//  iOSApp.swift
//  iOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import SwiftUI
import Combine

@main
struct iOSApp: App {
    @StateObject private var backendController = Backend.Controller(configuration: .live)
    private let pasteboard: UIPasteboard = .general
    private let storage = AppStorageCoreData()
    private let spacing = 12.0
    private let cols = 3
    private let columns: [GridItem]
    private let colors: [String: Color]
    @State private var apps: [Uicorn.App]
    @State private var isSheetPresented = false
    @State private var activeView: Uicorn.View?
    init() {
        let a = storage.fetchApps()
        apps = a
        colors = a.reduce(into: [:]) { $0[$1.id] = .systemRandom }
        columns = .init(repeating: .init(.flexible(), spacing: spacing), count: cols)
        //UINavigationBar.setupAppearance()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                GeometryReader { geo in
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(apps, id: \.id) { app in
                                VStack {
                                    colors[app.id]
                                        .frame(itemSize(forTotalSize: geo.size))
                                        .cornerRadius(15)
                                    Text(app.title)
                                        .lineLimit(1)
                                }
                                .id(app.id)
                                .onTapGesture {
                                    activeView = app.screens.first?.view
                                }
                            }
                        }
                        .padding(16)
                    }
                }
                .navigationTitle("Uicorn 🦄")
            }
            .navigationViewStyle(.stack)
            .onReceive(pasteboard.changedPublisher) { hasStrings in
                guard
                    let d = pasteboard.data(forPasteboardType: .pasteboardIdUicornApp),
                    let a = try? JSONDecoder().decode(Uicorn.App.self, from: d)
                else {
                    return
                }
                storage.store(a)
                pasteboard.items = []
            }
            .onChange(of: activeView) {
                isSheetPresented = $0 != nil
            }
            .fullScreenCover(isPresented: $isSheetPresented, onDismiss: clearActiveView) {
                NavigationView {
                    if let v = Binding($activeView) {
                        UicornView(v)
                            .environmentObject(backendController)
                            .navigationBarTitle("App")
                            .toolbar {
                                ToolbarItemGroup(placement: .navigationBarLeading) {
                                    Button {
                                        activeView = nil
                                    } label: {
                                        Label("Dashboard", systemImage: "")
                                            .labelStyle(.titleOnly)
                                    }
                                }
                            }
                    } else {
                        Text("😱")
                            .font(.system(.largeTitle).weight(.black))
                            .scaleEffect(5)
                    }
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
    private func clearActiveView() {
        activeView = nil
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
