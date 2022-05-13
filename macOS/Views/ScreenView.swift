//
//  ScreenView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct ScreenView: View {
    @Binding var screen: Uicorn.Screen
    init(_ s: Binding<Uicorn.Screen>) {
        _screen = s
    }
    var body: some View {
        UicornView($screen.view)
            .frame(width: 320, height: 568)
            .background(Color.white)
            .cornerRadius(15.0)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 1, y: 1)
            .allowsHitTesting(false)
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView(.constant(.preview))
    }
}

private extension Uicorn.Screen {
    static var preview: Uicorn.Screen {
        return .init(id: .unique, title: .init(), view: .mock)
    }
}
