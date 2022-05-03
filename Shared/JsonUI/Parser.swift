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
    init() {
        c.evaluateScript("function rectangle(t){return{type:\"rectangle\",attributes:t||{}}}function hstack(t,e){return{type:\"hstack\",children:t,attributes:e||{}}}function vstack(t,e){return{type:\"vstack\",children:t,attributes:e||{}}}function zstack(t,e){return{type:\"zstack\",children:t,attributes:e||{}}}function spacer(){return{type:\"spacer\"}}function text(t){return{type:\"text\",value:t}}function color(t){return rectangle({foregroundColor:t})}")
    }
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
