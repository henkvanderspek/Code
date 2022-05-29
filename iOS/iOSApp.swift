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
    private let apps: [Uicorn.App]
    private let colors: [String: Color]
    @State private var isSheetPresented = false
    @State private var activeView: Uicorn.View?
    init() {
        apps = storage.fetchApps()
        colors = apps.reduce(into: [:]) { $0[$1.id] = .systemRandom }
        columns = .init(repeating: .init(.flexible(), spacing: spacing), count: cols)
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
                                    isSheetPresented = true
                                }
                                .sheet(isPresented: $isSheetPresented) {
                                    if let v = activeView {
                                        UicornView(.constant(v))
                                            .environmentObject(backendController)
                                    } else {
                                        Text("😱")
                                            .font(.system(.largeTitle).weight(.black))
                                            .scaleEffect(5)
                                    }
                                }
                            }
                        }
                        .padding(16)
                    }
                }
                .navigationTitle("Uicorn")
            }
            .onReceive(pasteboard.changedPublisher) { hasStrings in
                guard
                    let s = pasteboard.string,
                    let d = s.data(using: .utf8),
                    let a = try? JSONDecoder().decode(Uicorn.App.self, from: d)
                else {
                    return
                }
                storage.store(a)
            }
        }
    }
    private func itemSize(forTotalSize size: CGSize) -> CGSize {
        let s = .init(cols - 1) * spacing
        let v = max(0, (size.width / .init(cols)) - s)
        return .init(width: v, height: v)
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
                    .map { _ in self.hasStrings }
            )
            .merge(
                with: NotificationCenter
                    .default
                    .publisher(for: UIApplication.didBecomeActiveNotification, object: nil)
                    .map { _ in self.hasStrings }
            )
            .eraseToAnyPublisher()
    }
}
