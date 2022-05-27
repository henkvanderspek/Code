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
    @State private var view: Uicorn.View = .helloWorld
    private let pasteboard: UIPasteboard = .general
    var body: some Scene {
        WindowGroup {
            UicornView($view)
                .ignoresSafeArea()
                .environmentObject(backendController)
                .onReceive(pasteboard.changedPublisher) { hasStrings in
                    guard
                        let s = pasteboard.string,
                        let d = s.data(using: .utf8),
                        let a = try? JSONDecoder().decode(Uicorn.App.self, from: d),
                        let v = a.screens.first?.view
                    else {
                        return
                    }
                    view = v
                }
        }
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
