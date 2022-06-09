//
//  DatabaseTreeViewState.swift
//  macOS
//
//  Created by Henk van der Spek on 06/06/2022.
//

import Foundation

class DatabaseTreeViewState: ObservableObject {
    private let database: DatabaseController
    init(_ db: DatabaseController) {
        database = db
        let item = DatabaseTreeItem(db)
        rootItem = item
        selectedItem = item
    }
    @Published var rootItem: TreeItem
    @Published var selectedItem: TreeItem
}

extension DatabaseTreeViewState {
    func selectItem(_ i: inout TreeItem) {
        selectedItem.isSelected = false
        i.isSelected = true
        selectedItem = i
    }
    var isTableSelected: Bool {
        rootItem.id != selectedItem.id
    }
    var selectedItemId: String {
        selectedItem.id
    }
}
