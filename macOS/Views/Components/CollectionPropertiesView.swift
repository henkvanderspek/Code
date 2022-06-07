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
                        ForEach(database.entities, id: \.id) {
                            Text($0.name)
                        }
                    }.onAppear {
                        model.mappings = $model.mappings.wrappedValue ?? $model.wrappedValue.view?.properties.map { .init(viewProperty: $0) } ?? []
                    }
                    if let id = model.entity, let e = database.entity(by: id), let mappings = Binding($model.mappings) {
                        ForEach(mappings, id: \.self) { $mapping in
                            Header($mapping.wrappedValue.viewProperty.localizedString)
                            Picker("Attribute", selection: Binding($mapping.databaseAttributeId, default: "")) {
                                ForEach(e.attributes, id: \.id) {
                                    Text($0.name)
                                }
                            }
                        }
                    }
                }
            }
        }
        .labelsHidden()
    }
}

private extension Uicorn.View {
    var properties: [Uicorn.View.Property] {
        switch type {
        case .map:
            return [
                .annotationTitle,
                .annotationCoordinate
            ]
        default:
            fatalError()
        }
    }
}

struct CollectionPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionPropertiesView(.constant(.init(type: .unsplash, parameters: ["query":"pug"], view: .image("{{url}}"))))
    }
}

extension Uicorn.View {
    enum Property: Codable, CaseIterable {
        case annotationTitle
        case annotationCoordinate
    }
}

extension Uicorn.View.Property {
    var localizedString: String {
        switch self {
        case .annotationTitle: return "Annotation Title"
        case .annotationCoordinate: return "Annotation Coordinate"
        }
    }
}
