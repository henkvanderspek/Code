//
//  iOSApp.swift
//  iOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import SwiftUI

@main
struct iOSApp: App {
    var body: some Scene {
        WindowGroup {
            JsonUIView(.mock)
                .ignoresSafeArea()
        }
    }
}
