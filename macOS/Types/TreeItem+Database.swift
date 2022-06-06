//
//  TreeItem+Database.swift
//  macOS
//
//  Created by Henk van der Spek on 06/06/2022.
//

import SwiftUI

struct DatabaseTreeItem {
    private let database: DatabaseController
    var children: [TreeItem]?
    var isSelected: Bool = false
    var isHidden: Bool = false
    var view: Uicorn.View? = nil
    init(_ db: DatabaseController) {
        database = db
        children = db.entities.map { EntityTreeItem($0) }
    }
    var title: String {
        "Database"
    }
    var systemImage: String {
        "opticaldiscdrive"
    }
    var id: String {
        database.databaseId
    }
}

extension DatabaseTreeItem: TreeItem {}

private struct EntityTreeItem {
    private let entity: Uicorn.Database.Entity
    var children: [TreeItem]?
    var isSelected: Bool = false
    var isHidden: Bool = false
    var view: Uicorn.View? = nil
    init(_ e: Uicorn.Database.Entity) {
        entity = e
        children = nil
    }
    var title: String {
        entity.name
    }
    var systemImage: String {
        "tablecells"
    }
    var id: String {
        entity.id
    }
}

extension EntityTreeItem: TreeItem {}
