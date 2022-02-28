//
//  ContentView.swift
//  macOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GridView(rows: 12, cols: 16)
            .frame(width: 640, height: 480)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
