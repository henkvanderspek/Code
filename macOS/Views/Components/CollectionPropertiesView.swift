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
        Section(header: Text("Type")) {
            Picker(selection: $model.type) {
                ForEach(Uicorn.View.Collection.CollectionType.allCases, id: \.self) {
                    Text($0.localizedTitle)
                }
            } label: {}
            switch model.type {
            case .unsplash:
                Text("Search")
                VStack {
                    TextEditor(text: Binding($model.query) ?? .constant(""))
                        .frame(minHeight: 100)
                        .padding(6)
                }
                .background(.background)
                .cornerRadius(4)
                .frame(minHeight: 20)
            }
        }
    }
}

struct CollectionPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionPropertiesView(model: .constant(.init(type: .unsplash, parameters: ["query":"pug"], view: .image("{{url}}"))))
    }
}
