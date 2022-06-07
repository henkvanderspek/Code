//
//  ValueProvider.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

class ValueProvider: ObservableObject {
    var children: [ValueProvider] = []
    func addChild(_ c: ValueProvider) {
        // TODO: Find a better way. Here the last one always wins while it should understand sibling scopes.
        children.append(c)
    }
    func provideValues(for v: Uicorn.View) -> Uicorn.View {
        return children.last?.provideValues(for: v) ?? v
    }
}

typealias EmptyValueProvider = ValueProvider
