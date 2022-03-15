//
//  JsonUI+Spacer.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import SwiftUI

extension JsonUIView {
    struct Spacer: View {
        let id = UUID()
        var body: some View {
            SwiftUI.Spacer()
        }
    }
}

struct JsonUIView_Spacer_Previews: PreviewProvider {
    static var previews: some View {
        JsonUIView.Spacer()
    }
}
