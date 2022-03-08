//
//  JsonUI+Script.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import SwiftUI

extension JsonUIView {
    struct Script: View {
        let id = UUID()
        let s: JsonUI.View.Script
        let p = ScriptParser()
        init(_ s: JsonUI.View.Script) {
            self.s = s
        }
        var body: some View {
            JsonUIView(p.parse(s.source))
        }
    }
}

struct JsonUIView_Script_Previews: PreviewProvider {
    static var previews: some View {
        JsonUIView.Script(.mock)
    }
}
