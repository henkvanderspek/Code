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
        // TODO: clear data model schema
        // TODO: update components if needed
        app = storage.fetchApps().first ?? .mock(.custom(.postInstances))
    }
    var body: some Scene {
        WindowGroup {
            AppView(app, storage: storage)
                .environmentObject(backendController)
        }
    }
}
