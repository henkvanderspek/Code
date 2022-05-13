//
//  Types.swift
//  Code
//
//  Created by Henk van der Spek on 14/03/2022.
//

import Foundation
import SwiftUI

#if os(macOS)
import AppKit
typealias NativeView = NSView
typealias NativeFont = NSFont
typealias NativeColor = NSColor
typealias NativeImage = NSImage
typealias NativeViewController = NSViewController
typealias LayoutPriority = NSLayoutConstraint.Priority
typealias LayoutGuide = NSLayoutGuide
#elseif os(iOS)
import UIKit
typealias NativeView = UIView
typealias NativeFont = UIFont
typealias NativeColor = UIColor
typealias NativeImage = UIImage
typealias NativeViewController = UIViewController
typealias LayoutPriority = UILayoutPriority
typealias LayoutGuide = UILayoutGuide
#endif

extension Color {
    init(nativeColor: NativeColor) {
    #if os(macOS)
        self.init(nsColor: nativeColor)
    #elseif os(iOS)
        self.init(uiColor: nativeColor)
    #endif
    }
}

extension Image {
    init(nativeImage image: NativeImage) {
    #if os(iOS)
        self.init(uiImage: image)
    #else
        self.init(nsImage: image)
    #endif
    }
}

#if os(macOS)

extension NativeColor {
    static var label: NativeColor {
        .labelColor // TODO:
    }
    static var systemGray: NativeColor {
        .gray // TODO:
    }
    static var systemGray2: NativeColor {
        .gray // TODO:
    }
    static var systemGray3: NativeColor {
        .gray // TODO:
    }
    static var systemGray4: NativeColor {
        .gray // TODO:
    }
    static var systemGray5: NativeColor {
        .gray // TODO:
    }
    static var systemGray6: NativeColor {
        .gray // TODO:
    }
    static var secondaryLabel: NativeColor {
        .secondaryLabelColor
    }
    static var quaternaryLabel: NativeColor {
        .quaternaryLabelColor
    }
    static var placeholderText: NativeColor {
        .placeholderTextColor
    }
    static var separator: NativeColor {
        .separatorColor
    }
    static var opaqueSeparator: NativeColor {
        .separatorColor // TODO:
    }
    static var link: NativeColor {
        .linkColor
    }
    static var systemBackground: NativeColor {
        .windowBackgroundColor
    }
}

extension NSView {
    var backgroundColor: NativeColor? {
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

extension Binding where Value: Equatable {
    init(_ s: Binding<Value>, default d: Value) {
        self.init(
            get: {
                s.wrappedValue
            },
            set: {
                s.wrappedValue = $0 == s.wrappedValue ? d : $0
            }
        )
    }
    init(_ s: Binding<Value?>, default d: Value) {
        self.init(
            get: {
                s.wrappedValue ?? d
            },
            set: {
                s.wrappedValue = $0 == s.wrappedValue ? d : $0
                print(s.wrappedValue)
            }
        )
    }
}
