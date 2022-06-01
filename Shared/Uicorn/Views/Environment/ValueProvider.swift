//
//  ValueProvider.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

class ValueProvider: ObservableObject {
    let instance: Uicorn.View.Instance?
    init(instance i: Uicorn.View.Instance? = nil) {
        instance = i
    }
    func provideValues(for v: Uicorn.View) -> Uicorn.View {
        if let val = instance?.values[v.id] {
            switch v.type {
            case let .image(i):
                print("Original: \(i.remote.url.suffix(10))")
                let img: Uicorn.View.Image = .init(type: .remote(value: .init(val.string ?? i.remote.url)))
                print("Modified: \(img.remote.url.suffix(10))")
                return .init(id: v.id, type: .image(value: img), action: v.action, properties: v.properties)
            default: () // TODO
            }
        }
        return v
    }
}

typealias EmptyValueProvider = ValueProvider
