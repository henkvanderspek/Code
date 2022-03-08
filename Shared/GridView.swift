//
//  GridView.swift
//  Code
//
//  Created by Henk van der Spek on 28/02/2022.
//

import SwiftUI

struct GridView: View {
    let rows: Int
    let cols: Int
    @Binding var text: String
    var body: some View {
        Canvas { c, s in
            s.divided(rows: rows, cols: cols).forEach {
                let res = [1, 2].randomElement()!
                $0.divided(rows: res, cols: res).forEach { r in
                    let clr = Color.random
                    c.fill(.init(r), with: .color(clr))
                    c.draw(
                        Text(verbatim: text)
                            .foregroundColor(clr.text)
                            .font(
                                .system(
                                    size: r.height * .random(in: 0.25...0.9),
                                    weight: [.light, .bold, .black, .heavy].randomElement()!,
                                    design: [.rounded, .serif, .monospaced, .default].randomElement()!
                                )
                            ),
                        at: r.center
                    )
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(rows: 2, cols: 2, text: .constant("f"))
    }
}

private extension Color {
    static var random: Self {
        [yellow, cyan, red, orange].randomElement()!
        // This is extremely slow to compile
        //[orange, red, yellow, teal, purple, pink, blue, green, cyan, indigo, mint, gray, white, black, brown].randomElement()!
    }
    var text: Self {
        switch self {
        case .orange:
            return [.white, .black, .yellow].randomElement()!
        case .yellow:
            return [.white, .black, .cyan].randomElement()!
        case .cyan, .red:
            return [.white, .black, .yellow].randomElement()!
        default:
            return .black
        }
    }
}

private extension CGSize {
    func divided(rows: Int, cols: Int) -> [CGRect] {
        CGRect(origin: .zero, size: self).divided(rows: rows, cols: cols)
    }
}

private extension CGRect {
    func divided(rows: Int, cols: Int) -> [CGRect] {
        let size = CGSize(width: width / .init(cols), height: height / .init(rows))
        let total = rows*cols
        return (0..<total).map {
            let col = CGFloat($0 % cols)
            let row = CGFloat($0 / cols)
            let origin = origin + CGPoint(x: col * size.width, y: row * size.height)
            return .init(origin: origin, size: size)
        }
    }
}

private extension CGPoint {
    static func + (lhs: Self, rhs: Self) -> Self {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

private extension CGRect {
    var center: CGPoint {
        .init(x: midX, y: midY)
    }
}
