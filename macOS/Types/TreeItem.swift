//
//  TreeItem.swift
//  macOS
//
//  Created by Henk van der Spek on 08/05/2022.
//

import Foundation

protocol TreeItem {
    var id: String { get }
    var title: String { get }
    var systemImage: String { get }
    var children: [TreeItem]? { get set }
    var isView: Bool { get }
    var canAddView: Bool { get }
    mutating func removeChild(byId: String)
}

extension TreeItem {
    var safeChildren: [TreeItem] {
        get {
            children ?? []
        }
        set {
            print(newValue)
        }
    }
    var hasChildren: Bool {
        !safeChildren.isEmpty
    }
    var isView: Bool {
        return false
    }
    func contains(_ id: String) -> Bool {
        return safeChildren.contains {
            $0.id == id || $0.contains(id)
        }
    }
    var canAddView: Bool {
        return false
    }
    mutating func removeChild(byId id: String) {
        children = children?.filter { $0.id != id }
    }
}
