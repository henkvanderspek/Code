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
    var body: some Scene {
        WindowGroup {
            AppView(.mock)
                .environmentObject(backendController)
        }
    }
}
