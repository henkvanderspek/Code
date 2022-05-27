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
    private var localStorage = LocalAppStorage()
    var body: some Scene {
        WindowGroup {
            AppView(.mock(.custom(.helloWorld)), storage: localStorage)
                .environmentObject(backendController)
        }
    }
}
