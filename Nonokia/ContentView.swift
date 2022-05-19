//
//  ContentView.swift
//  Nonokia
//
//  Created by Henk van der Spek on 19/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Device()
                .background(Color(0x1f2223))
                .frame(width: 240, height: 550)
                .cornerRadius(25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 8")
    }
}

struct Device: View {
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Color(0x070808)
                        .overlay {
                            LinearGradient(
                                stops: [
                                    .init(color: .black, location: 0),
                                    .init(color: .black, location: 0.2),
                                    .init(color: .white, location: 1),
                                ],
                                startPoint: .bottomTrailing,
                                endPoint: .topLeading
                            )
                            .opacity(0.25)
                        }
                    Color(0x070808)
                        .frame(height: 0.4 * geo.size.height)
                }
            }
            .cornerRadius(20)
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(
                    AngularGradient(
                        gradient: Gradient(
                            colors: [
                                .init(white: 1, opacity: 0.2),
                                .init(white: 1, opacity: 0.6),
                                .black
                            ]
                        ),
                        center: .center,
                        startAngle: .degrees(-270),
                        endAngle: .degrees(0)
                    ),
                    lineWidth: 1
                )
                .opacity(0.75)
        }
        .padding([.top, .leading, .trailing], 12)
        .padding([.bottom], 36)
    }
}

extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}
