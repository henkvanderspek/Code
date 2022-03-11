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
    func view(from key: String, props: [String: String]) -> JsonUI.View
}

struct Parser {
    private let c = JSContext()!
    private let d = XMLDecoder()
    func parse(_ s: String) -> JsonUI.View {
        return parse(s, function: "render")
    }
}

private extension Parser {
    func parse(_ s: String, function: String, props: [String: String] = [:]) -> JsonUI.View {
        c.evaluateScript(s)
        guard
            let s = c.evaluateScript(function).call(withArguments: [props]).toString(),
            let data = "<doc>\(s)</doc>".data(using: .utf8)
        else {
            return .text("💣")
        }
        d.userInfo = [.viewResolver: self]
        return (try? d.decode(JsonUI.View.self, from: data)) ?? .text("🤷‍♂️")
    }
}

extension Parser: ViewResolving {
    func view(from key: String, props: [String: String]) -> JsonUI.View {
        return parse(.init(), function: key, props: props)
    }
}

extension Decoder {
    func resolve() -> JsonUI.View {
        guard let k = currentItem, let p = userInfo[.viewResolver] as? ViewResolving else { return .empty }
        return p.view(from: k.name, props: k.attributes)
    }
}
