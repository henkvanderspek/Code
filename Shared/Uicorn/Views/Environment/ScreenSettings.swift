//
//  ScreenSettings.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

class ScreenSettings: ObservableObject {
    @Published var size: CGSize
    init(size s: CGSize) {
        size = s
    }
}

