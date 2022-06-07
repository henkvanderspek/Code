//
//  UicornView+DatabaseCollection.swift
//  Code
//
//  Created by Henk van der Spek on 05/06/2022.
//

import SwiftUI

extension UicornView {
    struct DatabaseCollection: View {
        @EnvironmentObject var database: DatabaseController
        @EnvironmentObject var valueProvider: ValueProvider
        @Binding var entity: String
        @Binding var view: Uicorn.View?
        @Binding var mappings: [Uicorn.View.Collection.Mapping]
        init(entity e: Binding<String>, view v: Binding<Uicorn.View?>, mappings m: Binding<[Uicorn.View.Collection.Mapping]>) {
            _entity = e
            _view = v
            _mappings = m
        }
        var body: some View {
            if let records: [Uicorn.Database.Record] = database.records(byEntity: $entity.wrappedValue) {
                if let v = Binding($view) {
                    UicornView(v)
                        .onAppear {
                            // TODO: addChild:forViewWithId maybe?
                            valueProvider.addChild(DatabaseCollectionValueProvider(records, mappings))
                        }
                }
            }
        }
    }
}

struct DatabaseCollection_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.DatabaseCollection(entity: .constant(.unique), view: .constant(.empty), mappings: .constant([]))
    }
}

private class DatabaseCollectionValueProvider: CollectionValueProvider {
    let records: [Uicorn.Database.Record]
    let mappings: [Uicorn.View.Collection.Mapping]
    init(_ r: [Uicorn.Database.Record], _ m: [Uicorn.View.Collection.Mapping]) {
        records = r
        mappings = m
    }
    override func provideValues(for v: Uicorn.View) -> Uicorn.View {
        switch v.type {
        case let .map(m):
            //print(mappings)
            m.annotations = records.compactMap { record in
                // TODO: Break this up
                let title = mappings.first(where: { $0.viewProperty == .annotationTitle }).map { m in record.values.first(where: { $0.attributeId == m.databaseAttributeId })?.string ?? "" } ?? ""
                guard let coordinate = mappings.first(where: { $0.viewProperty == .annotationCoordinate }).map { m in record.values.first(where: { $0.attributeId == m.databaseAttributeId })?.coordinate ?? nil } ?? nil else { return nil }
                return .init(name: title, coordinate: coordinate)
            }
        default: ()
        }
        return v
    }
}
