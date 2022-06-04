//
//  RelativeView.swift
//  Code
//
//  Created by Henk van der Spek on 04/06/2022.
//

import SwiftUI

protocol RelativeView: View {
    associatedtype Content: View
    func body(_ s: CGSize) -> Self.Content
}

extension RelativeView {
    var body: some View {
        GeometryReader { g in
            ZStack {
                body(g.size)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
