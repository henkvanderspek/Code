//
//  ScreenView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct ScreenView: View {
    @Binding var screen: JsonUI.Screen?
    init(_ s: Binding<JsonUI.Screen?>) {
        _screen = s
    }
    var body: some View {
        if let s = screen {
            JsonUIView(s.view)
                .frame(width: 320, height: 568)
                .background(Color.white)
                .cornerRadius(15.0)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 1, y: 1)
        }
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView(.constant(.mock))
    }
}

extension JsonUI.Screen {
    static var mock: Self {
        return .init(id: .unique, title: .init(), view: .mock)
    }
}
