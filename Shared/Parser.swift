//
//  ScriptRenderer.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import JavaScriptCore
import XMLCoder

struct Parser {
    private let c = JSContext()!
    private let d = XMLDecoder()
    func parse(_ s: String) -> JsonUI.View {
        c.evaluateScript(s)
        guard
            let s = c.evaluateScript("render()").toString(),
            let data = "<root>\(s)</root>".data(using: .utf8)
        else {
            return .text("💣")
        }
        return (try? d.decode(JsonUI.View.self, from: data)) ?? .text("🤷‍♂️")
    }
}
