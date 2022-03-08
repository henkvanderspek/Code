//
//  ScriptRenderer.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import JavaScriptCore

struct ScriptParser {
    private let c = JSContext()!
    private let d = JSONDecoder()
    init() {
        c.evaluateScript(#"""
            Function.prototype.convert = function() {
                return {
                    'type': 'script',
                    'source': this.toString()
                }
            }
            Function.prototype.toJSON = Function.prototype.convert
        }
        """#)
    }
    func parse(_ s: String) -> JsonUI.View {
        c.evaluateScript(s)
        guard
            let o = c.evaluateScript("render()").toObject(),
            let s = c.evaluateScript("JSON.stringify").call(withArguments: [o]).toString(),
            let data = s.data(using: .utf8)
        else {
            return .text("💣")
        }
        return (try? d.decode(JsonUI.View.self, from: data)) ?? .text("🤷‍♂️")
    }
}
