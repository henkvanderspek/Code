//
//  JsonUI+Image.swift
//  Code
//
//  Created by Henk van der Spek on 08/03/2022.
//

import SwiftUI

extension JsonUIView {
    struct Image: View {
        let view: JsonUI.View.Image
        init(_ v: JsonUI.View.Image) {
            view = v
        }
        var body: some View {
            SwiftUI.Image(systemName: "mustache.fill")
        }
    }
}

struct JsonUIView_Image_Previews: PreviewProvider {
    static var previews: some View {
        JsonUIView.Image(.init())
    }
}
