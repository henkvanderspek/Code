//
//  EditorView.swift
//  macOS
//
//  Created by Henk van der Spek on 03/05/2022.
//

import SwiftUI

extension JsonUI.App {
    var treeItem: TreeView.Item {
        return .init(id: id, title: title, systemImage: "iphone.homebutton", children: screens.map { $0.treeItem }, rootId: nil)
    }
}

extension JsonUI.Screen {
    var treeItem: TreeView.Item {
        return .init(id: id, title: title, systemImage: "rectangle.portrait", children: [view.treeItem(rootId: id)], rootId: id)
    }
}

extension JsonUI.View {
    func treeItem(rootId: String) -> TreeView.Item {
        return .init(id: id, title: shortName, systemImage: systemImage, children: children?.map { $0.treeItem(rootId: rootId) }, rootId: rootId)
    }
}

extension JsonUI.View {
    var shortName: String {
        ViewType(from: type).shortName
    }
    var systemImage: String {
        ViewType(from: type).systemImage
    }
}

private enum ViewType: String, Equatable, CaseIterable {
    case script
    case image
    case vstack
    case hstack
    case zstack
    case spacer
    case text
    case rectangle
    case empty
}

extension ViewType {
    init(from other: JsonUI.View.`Type`) {
        switch other {
        case .script: self = .script
        case .image: self = .image
        case .vstack: self = .vstack
        case .hstack: self = .hstack
        case .zstack: self = .zstack
        case .spacer: self = .spacer
        case .text: self = .text
        case .rectangle: self = .rectangle
        case .empty: self = .empty
        }
    }
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(shortName)
    }
}

extension ViewType {
    var systemImage: String {
        switch self {
        case .script: return "bolt.fill"
        case .image: return "photo"
        case .vstack: return "arrow.up.and.down.square"
        case .hstack: return "arrow.left.and.right.square"
        case .zstack: return "square.stack"
        case .spacer: return "arrow.left.and.right"
        case .text: return "t.square"
        case .rectangle: return "rectangle"
        case .empty: return "rectangle.dashed"
        }
    }
}

extension ViewType {
    var shortName: String {
        switch self {
        case .script: return "Script"
        case .image: return "Image"
        case .vstack: return "VStack"
        case .hstack: return "HStack"
        case .zstack: return "ZStack"
        case .spacer: return "Spacer"
        case .text: return "Text"
        case .rectangle: return "Rectangle"
        case .empty: return "Empty"
        }
    }
}

struct EditorView: View {
    let apps: [JsonUI.App]
    @State private var selectedItem: TreeView.Item = .empty
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
                    TreeView($0.treeItem, selectedItem: $selectedItem)
                }
            }
            .listStyle(.sidebar)
            DeviceView(apps: apps, selectedItem: $selectedItem)
                .navigationViewStyle(.columns)
                .navigationTitle("")
                .toolbar {
                    ToolbarItemGroup(placement: .navigation) {
                        Menu {
                            ForEach(ViewType.allCases, id: \.self) { type in
                                Button {
                                    print(type.shortName)
                                } label: {
                                    Label(type.shortName, systemImage: type.systemImage)
                                        .labelStyle(.titleAndIcon)
                                }.disabled(selectedItem.rootId == nil)
                            }
                        } label: {
                            Label("Add", systemImage: "plus")
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
