//
//  iOSApp.swift
//  iOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import SwiftUI

@main
struct iOSApp: App {
    @StateObject private var backendController = Backend.Controller(configuration: .live)
    var body: some Scene {
        WindowGroup {
            UicornView(.constant(.helloWorld))
                .ignoresSafeArea()
                .environmentObject(backendController)
        }
    }
}
