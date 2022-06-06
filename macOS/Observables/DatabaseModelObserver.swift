//
//  DatabaseModelObserver.swift
//  macOS
//
//  Created by Henk van der Spek on 06/06/2022.
//

import Foundation

class DatabaseModelObserver: ObservableObject {
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

extension DatabaseModelObserver {
    func selectItem(_ i: inout TreeItem) {
        selectedItem.isSelected = false
        i.isSelected = true
        selectedItem = i
    }
}
