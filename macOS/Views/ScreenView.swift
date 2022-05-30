//
//  ScreenView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

extension CGSize {
    static var defaultScreenSize: CGSize {
        .init(width: 320, height: 568)
    }
}

struct ScreenView: View {
    @Binding var screen: Uicorn.Screen
    @StateObject private var settings = ScreenSettings(size: .defaultScreenSize)
    init(_ s: Binding<Uicorn.Screen>) {
        _screen = s
    }
    var body: some View {
        HStack {
            if let v = Binding($screen.view) {
                UicornView(v)
                    .environmentObject(settings)
            } else {
                EmptyView()
            }
        }
        .frame(settings.size)
        .background(Color(.background))
        //.cornerRadius(15.0)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 1, y: 1)
        .allowsHitTesting(false)
    }
}

private extension View {
    func frame(_ s: CGSize) -> some View {
        frame(width: s.width, height: s.height)
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
