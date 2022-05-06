//
//  AppView.swift
//  macOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import SwiftUI

struct AppView: View {
    @State private var app: JsonUI.App = .mock
    var body: some View {
        EditorView(app: $app)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
