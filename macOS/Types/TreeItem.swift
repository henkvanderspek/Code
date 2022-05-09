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
    var children: [TreeItem]? { get }
    var isView: Bool { get }
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
    func contains(_ i: TreeItem) -> Bool {
        return safeChildren.contains {
            $0.id == i.id || $0.contains(i)
        }
    }
}
