//
//  TreeItemMenu.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import SwiftUI

struct TreeItemMenu: NSViewRepresentable {
    struct Item {
        let title: String
        let image: NSImage?
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
                    m.image = item.image
                    menu?.addItem(m)
                }
            }
        }
        override func hitTest(_ point: NSPoint) -> NSView? {
            switch window?.currentEvent?.type {
            case .rightMouseDown:
                settings?.mouseHandler()
                return super.hitTest(point)
            case .leftMouseDown:
                settings?.mouseHandler()
            default: ()
            }
            return nil
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
