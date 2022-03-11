//
//  ScriptRenderer.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import JavaScriptCore
import XMLCoder

private extension CodingUserInfoKey {
    static var viewResolver: Self {
        return .init(rawValue: "viewResolver")!
    }
}

private protocol ViewResolving {
    func view(from key: String) -> JsonUI.View
}

struct Parser {
    private let c = JSContext()!
    private let d = XMLDecoder()
    func parse(_ s: String) -> JsonUI.View {
        return parse(s, function: "render")
    }
}

private extension Parser {
    func parse(_ s: String, function: String) -> JsonUI.View {
        c.evaluateScript(s)
        guard
            let s = c.evaluateScript("\(function)()").toString(),
            let data = "<doc>\(s)</doc>".data(using: .utf8)
        else {
            return .text("💣")
        }
        d.userInfo = [.viewResolver: self]
        return (try? d.decode(JsonUI.View.self, from: data)) ?? .text("🤷‍♂️")
    }
}

extension Parser: ViewResolving {
    func view(from key: String) -> JsonUI.View {
        return parse(.init(), function: key)
    }
}

extension Decoder {
    func resolve() -> JsonUI.View {
        guard let k = currentKey, let p = userInfo[.viewResolver] as? ViewResolving else { return .empty }
        return p.view(from: k)
    }
}
