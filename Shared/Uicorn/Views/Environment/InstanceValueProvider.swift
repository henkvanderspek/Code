//
//  InstanceValueProvider.swift
//  Code
//
//  Created by Henk van der Spek on 07/06/2022.
//

import Foundation

class InstanceValueProvider: ValueProvider {
    let instance: Uicorn.View.Instance?
    init(instance i: Uicorn.View.Instance? = nil) {
        instance = i
    }
    override func provideValues(for v: Uicorn.View) -> Uicorn.View {
        if let val = instance?.values[v.id] {
            switch v.type {
            case let .image(i):
                print("Original: \(i.remote.url.suffix(10))")
                let img: Uicorn.View.Image = .init(type: .remote(value: .init(val.string ?? i.remote.url)))
                print("Modified: \(img.remote.url.suffix(10))")
                return v.type(.image(img))
            case let .text(t):
                print("Original: \(t.value)")
                let txt: Uicorn.View.Text = .init(val.string ?? t.value, font: t.font, alignment: t.alignment, textCase: t.textCase, foregroundColor: t.foregroundColor)
                print("Modified: \(txt.value)")
                return v.type(.text(txt))
            default: () // TODO
            }
        }
        return v
    }
}
