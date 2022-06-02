//
//  View+Modifiers.swift
//  Code
//
//  Created by Henk van der Spek on 02/06/2022.
//

import SwiftUI

extension View {
    func modifiers(_ m: Binding<[Uicorn.View.Modifier]>?, scaleFactor s: CGFloat) -> some View {
        guard let m = m else { return AnyView(self) }
        return m.reduce(into: AnyView(self)) {
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
                $0 = AnyView($0.background { UicornView(background(v)) })
            case .blendMode: // TODO: blend mode
                $0 = AnyView($0.blendMode(.normal))
            case .overlay: // TODO: overlay
                $0 = AnyView($0)
            }
        }
    }
    func frame(_ f: Uicorn.Frame, scaleFactor s: CGFloat) -> some View {
        frame(width: f.w?.multiplied(by: s), height: f.h?.multiplied(by: s), alignment: f.a)
    }
    func padding(_ p: Uicorn.Padding, scaleFactor s: CGFloat) -> some View {
        padding(.init(p, scaleFactor: s))
    }
    private func background(_ v: Uicorn.View) -> Binding<Uicorn.View> {
        .init(
            get: {
                v
            },
            set: { _ in
                fatalError()
            }
        )
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
