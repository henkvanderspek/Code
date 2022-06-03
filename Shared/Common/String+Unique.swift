//
//  String+Unique.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import Foundation

extension String {
    static var unique: Self {
        return UUID().uuidString
    }
}

