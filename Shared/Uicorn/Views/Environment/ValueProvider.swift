//
//  ValueProvider.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

class ValueProvider: ObservableObject {
    func provideValues(for v: Uicorn.View) -> Uicorn.View {
        return v
    }
}

typealias EmptyValueProvider = ValueProvider
