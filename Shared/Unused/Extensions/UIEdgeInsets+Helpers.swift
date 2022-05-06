//
//  UIEdgeInsets+Helpers.swift
//  Code
//
//  Created by Henk van der Spek on 14/03/2022.
//

#if os(iOS)
import UIKit
typealias EdgeInsets = UIEdgeInsets
#elseif os(macOS)
import AppKit
typealias EdgeInsets = NSEdgeInsets
#endif

extension EdgeInsets {
    static func all(_ value: CGFloat) -> Self {
        return .init(top: value, left: value, bottom: value, right: value)
    }
    static func top(_ value: CGFloat) -> Self {
        return .init(top: value, left: 0.0, bottom: 0.0, right: 0.0)
    }
    static func bottom(_ value: CGFloat) -> Self {
        return .init(top: 0.0, left: 0.0, bottom: value, right: 0.0)
    }
    static func horizontal(_ value: CGFloat) -> Self {
        return .init(top: 0.0, left: value, bottom: 0.0, right: value)
    }
    static func vertical(_ value: CGFloat) -> Self {
        return .init(top: value, left: 0.0, bottom: value, right: 0.0)
    }
    var reversed: EdgeInsets {
        return .init(top: -top, left: -left, bottom: -bottom, right: -right)
    }
    func multiplied(by f: CGFloat) -> Self {
        return .init(top: top * f, left: left * f, bottom: bottom * f, right: right * f)
    }
    func adjusted(by other: EdgeInsets) -> Self {
        return .init(top: top + other.top, left: left + other.left, bottom: bottom + other.bottom, right: right + other.right)
    }
}
