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
    @StateObject private var backendController = BackendController(configuration: .live)
    @StateObject private var databaseController = DatabaseController(configuration: .mock)
    private let storage = AppStorageCoreData()
    private let app: Uicorn.App
    init() {
        // TODO: clear data model schema
        // TODO: update components if needed
        app = storage.fetchApps().first ?? .mock(.custom(.postInstances))
    }
    var body: some Scene {
        WindowGroup {
            // TODO: Find a way to pass the database controller only once
            AppView(app, storage: storage, databaseController: databaseController)
                .environmentObject(backendController)
                .environmentObject(databaseController)
        }
    }
}
