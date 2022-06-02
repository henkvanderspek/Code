//
//  Padding+SwiftUI.swift
//  Code
//
//  Created by Henk van der Spek on 02/06/2022.
//

import SwiftUI

extension EdgeInsets {
    static var zero: Self {
        .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
    init(_ p: Uicorn.Padding, scaleFactor: CGFloat) {
        self.init(
            top: .init(p.top).multiplied(by: scaleFactor),
            leading: .init(p.leading).multiplied(by: scaleFactor),
            bottom: .init(p.bottom).multiplied(by: scaleFactor),
            trailing: .init(p.trailing).multiplied(by: scaleFactor)
        )
    }
}
