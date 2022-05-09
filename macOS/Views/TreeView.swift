//
//  TreeView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct TreeView<V: View>: View {
    @Binding var item: TreeItem
    let level: Int
    @State private var state: TreeItemState
    @Binding var selectedItem: TreeItem
    @State private var menuVisible = false
    private var menu: (TreeItem)->V
    init(_ i: Binding<TreeItem>, level l: Int = 0, selectedItem s: Binding<TreeItem>, menu m: @escaping (TreeItem)->V) {
        _item = i
        level = l
        _state = .init(initialValue: i.wrappedValue.hasChildren ? .parent(.expanded) : .leaf)
        _selectedItem = s
        menu = m
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                TreeItemStateView(state) // TODO: This should refresh on item change
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
                    .id(selectedItem.id)
                Image(systemName: $item.wrappedValue.systemImage)
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
                    .isHidden(!isSelected)
            )
            .cornerRadius(4)
            .contentShape(Rectangle())
            .overlay {
                menu(item)
            }
            if isExpanded {
                ForEach($item.safeChildren, id: \.id) { $item in
                    TreeView($item, level: level + 1, selectedItem: $selectedItem, menu: menu)
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
    private var isSelected: Bool {
        return $selectedItem.wrappedValue.id == $item.wrappedValue.id
    }
}

private enum TreeItemState {
    enum ParentItemState {
        case collapsed
        case expanded
    }
    case leaf
    case parent(ParentItemState)
}

private struct TreeItemStateView: View {
    let state: TreeItemState
    init(_ s: TreeItemState) {
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
