//
//  RelativeView.swift
//  Code
//
//  Created by Henk van der Spek on 04/06/2022.
//

import SwiftUI

struct MyText: View {
    var body: some View {
        Text("Foo")
    }
}

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

struct RelativeView_Previews: PreviewProvider {
    struct V: RelativeView {
        func body(_ s: CGSize) -> some View {
            HStack {
                MyText()
                    .frame(height: s.height / 2)
                    .padding()
                    .background(Color.yellow)
                MyText()
                    .frame(height: s.height / 4)
                    .padding()
                    .background(Color.yellow)
            }
        }
    }
    struct Outer: View {
        var body: some View {
            V()
        }
    }
    static var previews: some View {
        Outer()
    }
}
