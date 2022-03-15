//
//  NSDirectionalEdgeInsets+Helpers.swift
//  Code
//
//  Created by Henk van der Spek on 14/03/2022.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension NSDirectionalEdgeInsets {
    static func all(_ value: CGFloat) -> Self {
        return .init(top: value, leading: value, bottom: value, trailing: value)
    }
    static func horizontal(_ value: CGFloat) -> Self {
        return .init(top: 0.0, leading: value, bottom: 0.0, trailing: value)
    }
    static func vertical(_ value: CGFloat) -> Self {
        return .init(top: value, leading: 0.0, bottom: value, trailing: 0.0)
    }
    var horizontal: CGFloat {
        return leading + trailing
    }
    var vertical: CGFloat {
        return top + bottom
    }
    static func top(_ value: CGFloat) -> Self {
        return .init(top: value, leading: 0.0, bottom: 0.0, trailing: 0.0)
    }
    static func leading(_ value: CGFloat) -> Self {
        return .init(top: 0.0, leading: value, bottom: 0.0, trailing: 0.0)
    }
    static func bottom(_ value: CGFloat) -> Self {
        return .init(top: 0.0, leading: 0.0, bottom: value, trailing: 0.0)
    }
    static func trailing(_ value: CGFloat) -> Self {
        return .init(top: 0.0, leading: 0.0, bottom: 0.0, trailing: value)
    }
}
