//
//  ConfigurationStyle.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import CoreGraphics

struct ConfigurationStyle {
    let labelWidth: CGFloat
}

extension ConfigurationStyle {
    static var `default`: Self {
        .init(labelWidth: 90.0)
    }
}
