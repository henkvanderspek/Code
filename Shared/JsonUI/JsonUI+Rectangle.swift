//
//  JsonUI+Rectangle.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import SwiftUI

extension JsonUIView {
    struct Rectangle: View {
        let id = UUID()
        var body: some View {
            SwiftUI.Rectangle()
        }
    }
}

struct JsonUIView_Rectangle_Previews: PreviewProvider {
    static var previews: some View {
        JsonUIView.Rectangle()
    }
}
