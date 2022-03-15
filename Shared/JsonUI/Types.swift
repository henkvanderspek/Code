//
//  Types.swift
//  Code
//
//  Created by Henk van der Spek on 14/03/2022.
//

import Foundation

#if os(macOS)
import AppKit
typealias NativeView = NSView
typealias NativeFont = NSFont
typealias NativeColor = NSColor
typealias NativeViewController = NSViewController
typealias LayoutPriority = NSLayoutConstraint.Priority
typealias LayoutGuide = NSLayoutGuide
#elseif os(iOS)
import UIKit
typealias NativeView = UIView
typealias NativeFont = UIFont
typealias NativeColor = UIColor
typealias NativeViewController = UIViewController
typealias LayoutPriority = UILayoutPriority
typealias LayoutGuide = UILayoutGuide
#endif

#if os(macOS)
extension NSColor {
    static var systemBackground: NSColor {
        .windowBackgroundColor
    }
    static var label: NSColor {
        .labelColor // TODO:
    }
    static var systemGray: NSColor {
        .gray // TODO:
    }
    static var systemGray2: NSColor {
        .gray // TODO:
    }
    static var systemGray3: NSColor {
        .gray // TODO:
    }
    static var systemGray4: NSColor {
        .gray // TODO:
    }
    static var systemGray5: NSColor {
        .gray // TODO:
    }
}

extension NSView {
    var backgroundColor: NSColor? {
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
        get {
            layer?.backgroundColor.map { .init(cgColor: $0) } ?? nil
        }
    }
}

extension NSTextView {
    var alwaysBounceVertical: Bool {
        set {}
        get { return false }
    }
}

#endif
