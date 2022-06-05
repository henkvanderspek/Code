//
//  CollectionPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 12/05/2022.
//

import SwiftUI

struct CollectionPropertiesView: View {
    @EnvironmentObject var database: DatabaseController
    @Binding var model: Uicorn.View.Collection
    init(_ m: Binding<Uicorn.View.Collection>) {
        _model = m
    }
    var body: some View {
        Section {
            VGroup {
                Header("Type")
                Picker("Type", selection: $model.type) {
                    ForEach(Uicorn.View.Collection.allTypeCases, id: \.self) {
                        Text($0.localizedTitle)
                    }
                }
            }
            VGroup {
                switch model.type {
                case .unsplash:
                    TextEditorView(value: Binding($model.query, default: Uicorn.defaultUnsplashCollectionQuery), header: "Search")
                    StepperView($model.count, default: Uicorn.defaultUnsplashCollectionCount, range: 1...30, step: 1, header: "Count")
                case .sfSymbols:
                    EmptyView()
                case .database:
                    Header("Table")
                    Picker("Table", selection: Binding($model.entity, default: "")) {
                        ForEach(database.fetchEntities(), id: \.id) {
                            Text($0.name)
                        }
                    }
                }
            }
        }
        .labelsHidden()
    }
}

struct CollectionPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionPropertiesView(.constant(.init(type: .unsplash, parameters: ["query":"pug"], view: .image("{{url}}"))))
    }
}
