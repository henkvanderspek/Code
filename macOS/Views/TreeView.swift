//
//  TreeView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct TreeView<V: View>: View {
    @Binding var item: TreeItem
    var parent: Binding<TreeItem>?
    let level: Int
    @State private var state: TreeItemState
    @Binding var selectedItem: TreeItem
    @State private var menuVisible = false
    private var isParentHidden = false
    private var menu: (TreeView)->V
    init(_ i: Binding<TreeItem>, parent p: Binding<TreeItem>? = nil, level l: Int = 0, selectedItem s: Binding<TreeItem>, isParentHidden h: Bool = false, menu m: @escaping (TreeView)->V) {
        _item = i
        parent = p
        level = l
        _state = .init(initialValue: i.wrappedValue.hasChildren ? .parent(.expanded) : .leaf)
        _selectedItem = s
        isParentHidden = h
        menu = m
    }
    var body: some View {
        // TODO: Support arrow keys for selecting
        LazyVStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 2) {
                TreeItemStateView(state)
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
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 16)
                Text(item.title)
                Spacer()
            }
            .opacity(item.isHidden || isParentHidden ? 0.3 : 1.0)
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
                HStack {
                    Spacer()
                    Image(systemName: item.isHidden ? "eye.slash" : "eye")
                        .fixedSize()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 16)
                        .opacity(item.isHidden ? 0.7 : 0.3)
                        .isHidden(!item.isView)
                        .onTapGesture {
                            item.toggleVisibility()
                        }
                }
                .padding(.horizontal, 4)
                .isHidden(isParentHidden)
            }
            .overlay {
                menu(self)
            }
            if isExpanded {
                ForEach($item.safeChildren, id: \.id) { $child in
                    TreeView($child, parent: $item, level: level + 1, selectedItem: $selectedItem, isParentHidden: item.isHidden || isParentHidden, menu: menu)
                }
                .frame(maxWidth: .infinity)
                .animation(.easeInOut, value: isExpanded)
            }
        }
        .frame(maxWidth: .infinity)
        .onChange(of: item.hasChildren) { b in
            state = b ? .parent(.expanded) : .leaf
        }
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
