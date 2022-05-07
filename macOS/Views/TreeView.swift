//
//  TreeView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

extension AppItem {
    var safeChildren: [AppItem] {
        get {
            children ?? []
        }
        set {
            print(newValue)
        }
    }
}

struct TreeView: View {
    @Binding var item: AppItem
    let level: Int
    @State private var state: ItemState
    @Binding var selectedItem: AppItem
    init(_ i: Binding<AppItem>, level l: Int = 0, selectedItem s: Binding<AppItem>) {
        _item = i
        level = l
        state = i.wrappedValue.children?.isEmpty ?? true ? .leaf : .parent(.expanded)
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
                    .isHidden($selectedItem.wrappedValue.id != $item.wrappedValue.id)
            )
            .cornerRadius(4)
            .contentShape(Rectangle())
            .onTapGesture {
                selectedItem = item
            }
            if isExpanded {
                ForEach($item.safeChildren) { $item in
                    TreeView($item, level: level + 1, selectedItem: $selectedItem)
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
