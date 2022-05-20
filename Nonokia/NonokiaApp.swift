//
//  NonokiaApp.swift
//  Nonokia
//
//  Created by Henk van der Spek on 19/05/2022.
//

import SwiftUI

@main
struct NonokiaApp: App {
    var body: some Scene {
        WindowGroup {
            SceneView()
//            ContentView()
                .statusBar(hidden: true)
        }
    }
}

struct SceneView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SceneViewController {
        .init()
    }
    func updateUIViewController(_ uiViewController: SceneViewController, context: Context) {
    }
}
