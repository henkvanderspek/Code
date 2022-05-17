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
        Section {
            Header("Type")
            Picker("Type", selection: $model.type) {
                ForEach(Uicorn.View.Collection.allTypeCases, id: \.self) {
                    Text($0.localizedTitle)
                }
            }
            switch model.type {
            case .unsplash:
                Header("Search")
                VStack {
                    TextEditor(text: Binding($model.query, default: Uicorn.defaultUnsplashCollectionQuery))
                        .frame(minHeight: 100)
                        .padding(6)
                }
                .background(.background)
                .cornerRadius(4)
                .frame(minHeight: 20)
                Header("Count")
                HStack(spacing: 5) {
                    Text("\(model.count ?? Uicorn.defaultUnsplashCollectionCount)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Stepper("Count", value: Binding($model.count, default: Uicorn.defaultUnsplashCollectionCount), in: 1...20)
                }
                .frame(width: 80)
                .background(.background)
                .cornerRadius(4)
            }
        }
        .labelsHidden()
    }
}

struct CollectionPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionPropertiesView(model: .constant(.init(type: .unsplash, parameters: ["query":"pug"], view: .image("{{url}}", type: .remote))))
    }
}
