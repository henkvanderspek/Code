//
//  ScriptRenderer.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import JavaScriptCore

struct Parser {
    private let c = JSContext()!
    private let d = JSONDecoder()
    func parse(_ s: String) -> JsonUI.View {
        return parse(s, function: "render")
    }
}

private extension Parser {
    func parse(_ s: String, function: String, props: [String: String] = [:]) -> JsonUI.View {
        c.evaluateScript(s)
        guard
            let o = c.evaluateScript(function).call(withArguments: [props]).toObject(),
            let s = c.evaluateScript("JSON.stringify").call(withArguments: [o]).toString(),
            let data = s.data(using: .utf8)
        else {
            return .text("💣")
        }
        return (try? d.decode(JsonUI.View.self, from: data)) ?? .text("🤷‍♂️")
    }
}
