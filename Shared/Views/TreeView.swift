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
    @State private var isExpanded = true
    @State private var isSelected = false
    init(_ i: Item, level l: Int = 0) {
        item = i
        level = l
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: item.systemImage)
                    .fixedSize()
                    .frame(width: 20)
                Text(item.title)
                //Text(" (\(level))")
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding([.leading], .init(level * 15))
            .padding(4)
            .background(
                Color
//                    .black
//                    .opacity(0.075)
                    .orange
                    .isHidden(!isSelected)
            )
            .cornerRadius(4)
            .contentShape(Rectangle())
            .onTapGesture {
                isSelected.toggle()
            }
            if let children = item.children {
                ForEach(children, id: \.id) {
                    TreeView($0, level: level + 1)
                }.frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct TreeView_Previews: PreviewProvider {
    static var previews: some View {
        TreeView(.mock)
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

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
}
