//
//  NSLayoutConstraint+Helpers.swift
//  Code
//
//  Created by Henk van der Spek on 14/03/2022.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension Array where Element == NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate(self)
    }
    func deactivate() {
        NSLayoutConstraint.deactivate(self)
    }
}

extension NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate([self])
    }
}

protocol AnchorsContaining {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

extension NativeView: AnchorsContaining {}
extension LayoutGuide: AnchorsContaining {}

struct LayoutPriorities {
    let leading: LayoutPriority
    let trailing: LayoutPriority
    let top: LayoutPriority
    let bottom: LayoutPriority
    let width: LayoutPriority
    let height: LayoutPriority
}

extension LayoutPriorities {
    static func bottom(_ v: Float) -> Self {
        return .init(leading: .defaultHigh, trailing: .defaultHigh, top: .defaultHigh, bottom: .init(v), width: .init(v), height: .init(v))
    }
    static var required: Self {
        return.init(leading: .required, trailing: .required, top: .required, bottom: .required, width: .required, height: .required)
    }
}

extension NativeView {
    func constraint(to other: AnchorsContaining, priorities: LayoutPriorities? = nil) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(equalTo: other.leadingAnchor).prioritised(by: priorities?.leading ?? .defaultHigh),
            trailingAnchor.constraint(equalTo: other.trailingAnchor).prioritised(by: priorities?.trailing ?? .defaultHigh),
            topAnchor.constraint(equalTo: other.topAnchor).prioritised(by: priorities?.top ?? .defaultHigh),
            bottomAnchor.constraint(equalTo: other.bottomAnchor).prioritised(by: priorities?.bottom ?? .defaultHigh),
            widthAnchor.constraint(equalTo: other.widthAnchor).prioritised(by: priorities?.width ?? .defaultHigh),
            heightAnchor.constraint(equalTo: other.heightAnchor).prioritised(by: priorities?.height ?? .defaultHigh)
        ]
    }
    func center(in other: AnchorsContaining, priorities: LayoutPriorities? = nil) -> [NSLayoutConstraint] {
        return [
            centerXAnchor.constraint(equalTo: other.centerXAnchor).prioritised(by: priorities?.leading ?? .defaultHigh),
            centerYAnchor.constraint(equalTo: other.centerYAnchor).prioritised(by: priorities?.trailing ?? .defaultHigh),
        ]
    }
    func stretch() {
        let a = [
            widthAnchor.constraint(greaterThanOrEqualToConstant: 0).prioritised(by: .required),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 0).prioritised(by: .required)
        ]
        a.activate()
    }
}

extension NSLayoutConstraint {
    func prioritised(by priority: LayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

#if os(iOS)
extension UIView {
    func embed(_ view: UIView, animations: (()->())? = nil, completion: (()->())? = nil) {
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.constraint(to: self, priorities: .required).activate()
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: { animations?(); view.alpha = 1 }) { finished in
                guard finished else { return }
                completion?()
            }
        }
    }
}

extension UIViewController {
    func embed(_ vc: UIViewController, removeCurrent: Bool = false) {
        let c = removeCurrent ? children : []
        addChild(vc)
        view.embed(
            vc.view,
            animations: { c.forEach { $0.view.alpha = 0 } },
            completion: { vc.didMove(toParent: self); c.remove() }
        )
    }
}

extension Array where Element == UIViewController {
    func remove() {
        forEach { $0.remove() }
    }
    func hide() {
        forEach { $0.view.isHidden = true }
    }
}

extension UIViewController {
    func remove() {
        view.removeFromSuperview()
        willMove(toParent: nil)
        removeFromParent()
    }
    func removeChildren() {
        children.forEach { $0.remove() }
    }
}
#endif
