//
//  CollectionPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 12/05/2022.
//

import SwiftUI

struct CollectionPropertiesView: View {
    @Binding var model: Uicorn.View.Collection
    var body: some View {
        switch model.type {
        case .unsplash:
            VStack(alignment: .leading) {
                Text("Search")
                    .font(.title3)
                    .opacity(0.6)
                TextEditor(text: Binding($model.query) ?? .constant(""))
                    .frame(minHeight: 100)
            }
        }
    }
}

struct CollectionPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionPropertiesView(model: .constant(.init(type: .unsplash, parameters: ["query":"pug"], view: .image("{{url}}"))))
    }
}
