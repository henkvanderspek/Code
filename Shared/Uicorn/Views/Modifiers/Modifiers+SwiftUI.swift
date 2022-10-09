//
//  View+Modifiers.swift
//  Code
//
//  Created by Henk van der Spek on 02/06/2022.
//

import SwiftUI

extension View {
    func modifiers(_ m: Binding<[Uicorn.View.Modifier]>?, scaleFactor s: CGFloat) -> some View {
        // TODO: Found out if all this type erasing is inefficient
        m?.reduce(into: AnyView(self)) {
            switch $1.wrappedValue.type {
            case let .frame(f):
                $0 = AnyView($0.frame(f, scaleFactor: s))
            case let .padding(p):
                $0 = AnyView($0.padding(p, scaleFactor: s))
            case let .cornerRadius(v):
                $0 = AnyView($0.cornerRadius(.init(v).multiplied(by: s)))
            case let .opacity(v):
                $0 = AnyView($0.opacity(.init(v)))
            case let .background(v):
                $0 = AnyView($0.background { UicornView(v.binding) })
            case let .blendMode(v):
                $0 = AnyView($0.blendMode(.init(v)))
            case let .overlay(v):
                $0 = AnyView($0.overlay { UicornView(v.binding) })
            }
        } ?? AnyView(self)
    }
    func frame(_ f: Uicorn.Frame, scaleFactor s: CGFloat) -> some View {
        frame(width: f.w?.multiplied(by: s), height: f.h?.multiplied(by: s), alignment: f.a)
    }
    func padding(_ p: Uicorn.Padding, scaleFactor s: CGFloat) -> some View {
        padding(.init(p, scaleFactor: s))
    }
}

private extension Uicorn.Frame {
    var w: CGFloat? {
        let v = width.map { CGFloat($0) }
        return v ?? 0 > 0 ? v : nil
    }
    var h: CGFloat? {
        let v = height.map { CGFloat($0) }
        return v ?? 0 > 0 ? v : nil
    }
    var a: Alignment {
        .init(alignment)
    }
}

private extension Uicorn.Metric {
    var v: CGFloat? {
        let ret = CGFloat(value)
        return ret > 0 ? ret : nil
    }
}

extension Uicorn.View: Bindable {}
