//
//  Padding.swift
//  Uicorn
//
//  Created by Henk van der Spek on 18/05/2022.
//

import Foundation

extension Uicorn {
    class Padding: Codable {
        var leading: Int
        var trailing: Int
        var top: Int
        var bottom: Int
        init(leading: Int, trailing: Int, top: Int, bottom: Int) {
            self.leading = leading
            self.trailing = trailing
            self.top = top
            self.bottom = bottom
        }
    }
}
