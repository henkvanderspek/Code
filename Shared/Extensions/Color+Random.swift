//
//  Color+Random.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    static var systemRandom: Color {
        return [
            .yellow,
            .blue,
            .red,
            .orange,
            .green,
            .mint,
            .teal,
            .cyan,
            .indigo,
            .purple,
            .pink,
            .brown
        ].randomElement()!
    }
}
