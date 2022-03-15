//
//  JsonUI+Editor.swift
//  Code
//
//  Created by Henk van der Spek on 14/03/2022.
//

import SwiftUI

struct JsonUIEditor: View {
    var body: some View {
        EditorViewRepresenation()
    }
}

struct JsonUIEditor_Previews: PreviewProvider {
    static var previews: some View {
        JsonUIEditor()
    }
}

#if os(macOS)
struct EditorViewRepresenation: NSViewRepresentable {
    func makeNSView(context: Context) -> some NSView {
        return EditorView()
    }
    func updateNSView(_ nsView: NSViewType, context: Context) {
    }
}
#elseif os(iOS)
struct EditorViewRepresenation: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return EditorView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
#endif
