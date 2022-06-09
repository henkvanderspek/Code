//
//  AppTreeViewState.swift
//  macOS
//
//  Created by Henk van der Spek on 06/06/2022.
//

import SwiftUI

class AppTreeViewState: ObservableObject {
    init(_ a: Uicorn.App) {
        app = a
        rootItem = a
        selectedItem = a
    }
    @Published var app: Uicorn.App // TODO: use rootItem
    @Published var rootItem: TreeItem
    @Published var selectedItem: TreeItem
}

extension AppTreeViewState {
    var sanitizedScreen: Uicorn.Screen? {
        get {
            rootItem.screen(by: selectedItem.id) as? Uicorn.Screen
        }
        set {
            fatalError()
        }
    }
    var sanitizedSelectedItem: Binding<Uicorn.View> {
        return .init(
            get: {
                if self.selectedItem.isView {
                    return self.selectedItem.view ?? .empty
                } else {
                    return .empty
                }
            },
            set: {
                self.selectedItem = $0
            }
        )
    }
    func embedInHStack(_ i: TreeItem) {
        i.view?.embeddedInHStack()
        objectWillChange.send()
    }
    func embedInVStack(_ i: TreeItem) {
        i.view?.embeddedInVStack()
        objectWillChange.send()
    }
    func embedInZStack(_ i: TreeItem) {
        i.view?.embeddedInZStack()
        objectWillChange.send()
    }
    func delete(_ i: TreeItem, from parent: Binding<TreeItem>) {
        var p = parent.wrappedValue
        p.removeChild(byId: i.id)
        selectedItem = p
        objectWillChange.send()
    }
    func toggleVisibility() {
        guard let h = selectedItem.view?.isHidden else { return }
        selectedItem.view?.isHidden = !h
        objectWillChange.send()
    }
    func addView(ofType t: ViewType) {
        selectedItem.addView(.from(t))
        selectedItem = selectedItem.children?.last ?? selectedItem
        objectWillChange.send()
    }
    // TODO: Do we still need these?
    func update(_ t: Uicorn.View.`Type`) {
        selectedItem.view?.type = t
        sendWillChange()
    }
    func update(_ c: Uicorn.View.Collection) {
        update(.collection(c))
    }
    func update(_ s: Uicorn.View.Shape) {
        update(.shape(s))
    }
    func update(_ t: Uicorn.View.Text) {
        update(.text(t))
    }
    func update(_ i: Uicorn.View.Image) {
        update(.image(i))
    }
    func update(_ m: Uicorn.View.Map) {
        update(.map(m))
    }
    func update(_ s: Uicorn.View.Scroll) {
        update(.scroll(s))
    }
    func update(_ i: Uicorn.View.Instance) {
        update(.instance(i))
    }
    func update(_ c: Uicorn.Color) {
        update(.color(c))
    }
    func update(_ m: Uicorn.View.Modifiers) {
        selectedItem.view?.modifiers = m
        sendWillChange()
    }
    func sendWillChange() {
        objectWillChange.send()
    }
    func selectItem(_ i: inout TreeItem) {
        // TODO: Possible cause for occasional crash
        selectedItem.isSelected = false
        i.isSelected = true
        selectedItem = i
    }
}
