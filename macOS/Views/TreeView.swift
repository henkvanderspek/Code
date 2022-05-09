//
//  TreeView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct TreeView: View {
    @Binding var item: TreeItem
    let level: Int
    @State private var state: TreeItemState
    @Binding var selectedItem: TreeItem
    @State private var menuVisible = false
    init(_ i: Binding<TreeItem>, level l: Int = 0, selectedItem s: Binding<TreeItem>) {
        _item = i
        level = l
        _state = .init(initialValue: i.wrappedValue.hasChildren ? .parent(.expanded) : .leaf)
        _selectedItem = s
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
                Menu(menuItems)
                    .isDisabled(!item.isView)
                    .tapGesture {
                        selectedItem = item
                    }
            }
            if isExpanded {
                ForEach($item.safeChildren, id: \.id) { $item in
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
    private var isSelected: Bool {
        return $selectedItem.wrappedValue.id == $item.wrappedValue.id
    }
    private func menuItems() -> [Menu.Item] {
        return [
            .init(title: "Embed in HStack") {
                print("Embed in hstack")
            }
        ]
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

extension TreeView {
    private struct Menu: NSViewRepresentable {
        struct Item {
            let title: String
            let action: ()->()
        }
        struct Coordinator {
            let items: [Item]
        }
        let items: ()->[Item]
        init(_ i: @escaping ()->[Item]) {
            items = i
        }
        private var tapGestureHandler: (()->())?
        private var isEnabled = true
        class V: NSView {
            struct Settings {
                let items: [Item]
                let mouseHandler: ()->()
                let shouldShowMenu: ()->Bool
            }
            var settings: Settings? {
                didSet {
                    guard let s = settings, !s.items.isEmpty, s.shouldShowMenu() else { return }
                    menu = NSMenu()
                    s.items.enumerated().forEach { index, item in
                        let m = NSMenuItem(title: item.title, action: #selector(tappedItem), keyEquivalent: "")
                        m.target = self
                        m.tag = index
                        menu?.addItem(m)
                    }
                }
            }
            override func mouseDown(with event: NSEvent) {
                settings?.mouseHandler()
                super.mouseDown(with: event)
            }
            override func rightMouseDown(with event: NSEvent) {
                settings?.mouseHandler()
                super.rightMouseDown(with: event)
            }
            @objc private func tappedItem(_ sender: AnyObject) {
                guard let i = sender as? NSMenuItem else { return }
                settings?.items[i.tag].action()
            }
        }
        func makeNSView(context: Context) -> V {
            let v = V()
            v.focusRingType = .none
            v.settings = .init(
                items: context.coordinator.items,
                mouseHandler: {
                    tapGestureHandler?()
                },
                shouldShowMenu: {
                    isEnabled
                }
            )
            return v
        }
        func updateNSView(_ view: V, context: Context) {
        }
        func makeCoordinator() -> Coordinator {
            return .init(items: items())
        }
        func tapGesture(_ action: @escaping ()->()) -> Self {
            var v = self
            v.tapGestureHandler = action
            return v
        }
        func isDisabled(_ b: Bool) -> Self {
            var v = self
            v.isEnabled = !b
            return v
        }
    }
}
