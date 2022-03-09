//
//  ContentView.swift
//  iOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        jsonUIView()
    }
}

extension ContentView {
    func gridView() -> some View {
        GridView(rows: 12, cols: 8, text: .constant("f"))
    }
    func jsonUIView() -> some View {
        JsonUIView(.script(.mock))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
