//
//  EditorView.swift
//  macOS
//
//  Created by Henk van der Spek on 03/05/2022.
//

import SwiftUI

struct Tree<Value: Hashable>: Hashable {
    let value: Value
    let name: String
    let children: [Tree]?
}

extension JsonUI.Screen {
    var tree: Tree<String> {
        return .init(value: id, name: title, children: [view.tree])
    }
}

extension JsonUI.View {
    var tree: Tree<String> {
        return .init(value: id, name: displayName, children: children?.map { $0.tree })
    }
}

struct EditorView: View {
    let app: JsonUI.App
    var body: some View {
        NavigationView {
            List(app.screens.map { $0.tree }, id: \.value, children: \.children) { tree in
                Text(tree.name)
            }.listStyle(SidebarListStyle())
            Text("Preview")
                .navigationViewStyle(.columns)
                .navigationTitle("")
                .toolbar {
                    ToolbarItemGroup(placement: .navigation) {
                        Button {
                            print("Save pressed")
                        } label: {
                            Label("Save", systemImage: "mustache")
                                .fixedSize()
                                .padding()
                                .frame(width: 15.0)
                        }
                    }
                }
            Text("Properties")
        }
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView(app: .mock)
    }
}
