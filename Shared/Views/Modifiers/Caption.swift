//
//  Caption.swift
//  Code
//
//  Created by Henk van der Spek on 16/03/2022.
//
import SwiftUI

extension View {
    func caption(_ s: String?, padding p: Double, design: Font.Design = .serif) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            self
            if let s = s {
                Text(s)
                    .font(.system(.caption2, design: design))
                    .padding(.horizontal, p)
            }
        }
    }
}
