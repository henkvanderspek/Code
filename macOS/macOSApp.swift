//
//  macOSApp.swift
//  macOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import SwiftUI

@main
struct macOSApp: App {
    @State private var app: JsonUI.App = .mock
    var body: some Scene {
        WindowGroup {
            AppView($app)
        }
    }
}
