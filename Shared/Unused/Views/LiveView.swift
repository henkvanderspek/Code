//
//  LiveView.swift
//  Code
//
//  Created by Henk van der Spek on 01/03/2022.
//

import SwiftUI

struct LiveView: View {
    @State private var circleScale = 1.0
    private let maxCircleScale = 1.75
    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .frame(width: 5, height: 5)
                .scaleEffect(circleScale)
                .opacity(circleScale / maxCircleScale)
                .animation(.easeOut(duration: 1).repeatForever(autoreverses: true), value: circleScale)
                .onAppear() {
                    circleScale = maxCircleScale
                }
            Text("Live").font(.system(.subheadline)).textCase(.uppercase)
        }
        .padding(8)
        .background(.red)
        .foregroundColor(.white)
        .cornerRadius(5)
    }
}

struct LiveView_Previews: PreviewProvider {
    static var previews: some View {
        LiveView()
    }
}
