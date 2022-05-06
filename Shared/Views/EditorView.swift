//
//  EditorView.swift
//  macOS
//
//  Created by Henk van der Spek on 03/05/2022.
//

import SwiftUI

extension JsonUI.App {
    var treeItem: TreeView.Item {
        return .init(id: id, title: title, systemImage: "iphone.homebutton", children: screens.map { $0.treeItem })
    }
}

extension JsonUI.Screen {
    var treeItem: TreeView.Item {
        return .init(id: id, title: title, systemImage: "rectangle.portrait", children: [view.treeItem])
    }
}

extension JsonUI.View {
    var treeItem: TreeView.Item {
        return .init(id: id, title: displayName, systemImage: systemImage, children: children?.map { $0.treeItem })
    }
}

extension JsonUI.View {
    var systemImage: String {
        switch type {
        case .script: return "bolt.fill"
        case .image: return "photo"
        case .vstack: return "arrow.up.and.down.square"
        case .hstack: return "arrow.left.and.right.square"
        case .zstack: return "square.stack"
        case .spacer: return "arrow.left.and.right"
        case .text: return "t.square"
        default: return "folder"
        }
    }
}

struct EditorView: View {
    let apps: [JsonUI.App]
    @State private var selectedItemId: String = .init()
    var body: some View {
        NavigationView {
//            List(app.screens.map { $0.treeItem }, id: \.id, children: \.children) { item in
//                HStack {
//                    Image(systemName: "folder")
//                    Text(item.name)
//                }
//            }
            List {
                ForEach(apps, id: \.id) {
                    TreeView($0.treeItem, selectedItemId: $selectedItemId)
                }
            }
            .listStyle(.sidebar)
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
        EditorView(apps: [.mock])
    }
}
