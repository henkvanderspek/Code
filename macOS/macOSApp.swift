//
//  macOSApp.swift
//  macOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import Cocoa
import SwiftUI

@main
struct macOSApp: App {
    @StateObject private var backendController = Backend.Controller(configuration: .live)
    private let storage = AppStorageCoreData()
    private let app: Uicorn.App
    init() {
        app = storage.fetchApps().first ?? .mock(.custom(.helloWorld))
    }
    var body: some Scene {
        WindowGroup {
            AppView(app, storage: storage)
                .environmentObject(backendController)
        }
    }
}
