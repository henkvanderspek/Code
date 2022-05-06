//
//  TreeView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct TreeView: View {
    // TODO: Ideally this holds a reference to the underlying jsonui view, so preview doesn't have to hold apps and search for the screen
    // TODO: Obviously we don't want to embed a jsonui screen, since it would make this tree view non generic
    // TODO: Tried generic but it didn't work, state started complaining
    struct Item: Hashable {
        let id: String
        let title: String
        let systemImage: String
        let children: [Item]?
        let rootId: String?
    }
    let item: Item
    let level: Int
    @State private var state: ItemState
    @Binding var selectedItem: Item
    init(_ i: Item, level l: Int = 0, selectedItem s: Binding<Item>) {
        item = i
        level = l
        state = i.children?.isEmpty ?? true ? .leaf : .parent(.expanded)
        _selectedItem = s
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                ItemStateView(state)
                    .font(.subheadline.weight(.bold))
                    .imageScale(.small)
                    .fixedSize()
                    .frame(width: 10.0)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        switch state {
                        case .leaf: ()
                        case let .parent(p):
                            state = .parent(p == .collapsed ? .expanded : .collapsed)
                        }
                    }
                Image(systemName: item.systemImage)
                    .fixedSize()
                    .frame(width: 20)
                Text(item.title)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding([.leading], .init(level * 12))
            .padding(4)
            .background(
                Color
                    .orange
                    .isHidden($selectedItem.wrappedValue.id != item.id)
            )
            .cornerRadius(4)
            .contentShape(Rectangle())
            .onTapGesture {
                selectedItem = item
            }
            if let children = item.children, isExpanded {
                ForEach(children, id: \.id) {
                    TreeView($0, level: level + 1, selectedItem: $selectedItem)
                }
                .frame(maxWidth: .infinity)
                .animation(.easeInOut, value: isExpanded)
            }
        }
        .frame(maxWidth: .infinity)
    }
    private var isExpanded: Bool {
        guard case .parent(.expanded) = state else { return false }
        return true
    }
}

struct TreeView_Previews: PreviewProvider {
    static var previews: some View {
        TreeView(.mock, selectedItem: .constant(.mock))
    }
}

extension TreeView.Item {
    static var empty: Self {
        return .init(id: .init(), title: .init(), systemImage: .init(), children: nil, rootId: nil)
    }
    static var mock: Self {
        return .init(
            id: .unique,
            title: "Root",
            systemImage: "folder",
            children: [
                .init(
                    id: .unique,
                    title: "Child",
                    systemImage: "mustache",
                    children: nil,
                    rootId: nil
                )
            ],
            rootId: nil
        )
    }
}

private enum ItemState {
    enum ParentState {
        case collapsed
        case expanded
    }
    case leaf
    case parent(ParentState)
}

private struct ItemStateView: View {
    let state: ItemState
    init(_ s: ItemState) {
        state = s
    }
    var body: some View {
        switch state {
        case .leaf:
            Color.clear
        case let .parent(c):
            switch c {
                case .collapsed:
                    Image(systemName: "chevron.right")
                case .expanded:
                    Image(systemName: "chevron.down")
            }
        }
    }
}
