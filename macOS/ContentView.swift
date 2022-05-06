//
//  ContentView.swift
//  macOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        editorView()
    }
}

private extension ContentView {
//    func gridView() -> some View {
//        GridView(rows: 12, cols: 12, text: .constant("f"))
//            .frame(width: 512, height: 512, alignment: .topLeading)
//    }
//    func newsView() -> some View {
//        NewsView()
//            .background(.background)
//            .frame(width: 375, height: 667, alignment: .topLeading)
//    }
//    func jsonUIView() -> some View {
//        JsonUIView(.script(.mock))
//            .frame(width: 320, height: 240)
//    }
//    func newspaperView() -> some View {
//        NewspaperView(.mock)
//            .frame(width: 320, height: 240)
//    }
//    func terminalView() -> some View {
//        TerminalView()
//    }
    func editorView() -> some View {
        EditorView(apps: [.mock])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
