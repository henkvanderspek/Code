//
//  CustomFormatter.swift
//  Code
//
//  Created by Henk van der Spek on 16/03/2022.
//

import Foundation

struct CustomFormatter {
    lazy var relativeDateFormatter: DateFormatter = {
        $0.timeStyle = .none
        $0.dateStyle = .long
        $0.doesRelativeDateFormatting = true
        return $0
    }(DateFormatter())
    static var shared = CustomFormatter()
}

extension CustomFormatter {
    static func relativeString(from date: Date) -> String {
        shared.relativeDateFormatter.string(from: date)
    }
}
