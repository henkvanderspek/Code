//
//  JsonUI+Padding.swift
//  Code
//
//  Created by Henk van der Spek on 10/03/2022.
//

import SwiftUI

extension JsonUI.View.Attributes.Padding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.leading, leading.map { .init($0) } ?? 0)
            .padding(.trailing, trailing.map { .init($0) } ?? 0)
            .padding(.top, top.map { .init($0) } ?? 0)
            .padding(.bottom, bottom.map { .init($0) } ?? 0)
    }
}

extension JsonUI.View.Attributes.Padding {
    static var zero: Self {
        .init(leading: nil, trailing: nil, top: nil, bottom: nil)
    }
    static func all(_ v: Int) -> Self {
        .init(leading: v, trailing: v, top: v, bottom: v)
    }
}

extension View {
    func padding(_ p: JsonUI.View.Attributes.Padding?) -> some View {
        guard let p = p else { return AnyView(self) }
        return AnyView(modifier(p))
    }
}
