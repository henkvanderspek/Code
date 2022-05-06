//
//  TreeView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct TreeView: View {
    struct Item: Hashable {
        let id: String
        let title: String
        let systemImage: String
        let children: [Item]?
    }
    let item: Item
    let level: Int
    @State private var state: ItemState
    @Binding var selectedItemId: String
    init(_ i: Item, level l: Int = 0, selectedItemId s: Binding<String>) {
        item = i
        level = l
        state = i.children?.isEmpty ?? true ? .leaf : .parent(.expanded)
        _selectedItemId = s
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
            .padding([.leading], .init(level * 15))
            .padding(4)
            .background(
                Color
                    .orange
                    .isHidden($selectedItemId.wrappedValue != item.id)
            )
            .cornerRadius(4)
            .contentShape(Rectangle())
            .onTapGesture {
                selectedItemId = item.id
            }
            if let children = item.children, case .parent(.expanded) = state {
                ForEach(children, id: \.id) {
                    TreeView($0, level: level + 1, selectedItemId: $selectedItemId)
                }.frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct TreeView_Previews: PreviewProvider {
    static var previews: some View {
        TreeView(.mock, selectedItemId: .constant(""))
    }
}

extension TreeView.Item {
    static var mock: Self {
        return .init(
            id: UUID().uuidString,
            title: "Root",
            systemImage: "folder",
            children: [
                .init(
                    id: UUID().uuidString,
                    title: "Child",
                    systemImage: "mustache",
                    children: nil
                )
            ]
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
