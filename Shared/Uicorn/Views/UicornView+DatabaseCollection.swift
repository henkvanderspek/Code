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
        init(entity e: Binding<String>, view v: Binding<Uicorn.View?>) {
            _entity = e
            _view = v
        }
        var body: some View {
            if let records: [Uicorn.Database.Record] = database.records(byEntity: $entity.wrappedValue) {
                if let v = Binding($view) {
                    UicornView(v)
                        .onAppear {
                            // TODO: addChild:forViewWithId maybe?
                            valueProvider.addChild(DatabaseCollectionValueProvider(records))
                        }
                }
            }
        }
    }
}

struct DatabaseCollection_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.DatabaseCollection(entity: .constant(.unique), view: .constant(.empty))
    }
}

private class DatabaseCollectionValueProvider: CollectionValueProvider {
    let records: [Uicorn.Database.Record]
    init(_ r: [Uicorn.Database.Record]) {
        records = r
    }
    override func provideValues(for v: Uicorn.View) -> Uicorn.View {
        switch v.type {
        case let .map(m):
            // TODO: This mapping should be provided by user instead
            // TODO: We can't know which field to use for the coordinate and which for the title
            m.annotations = records.flatMap {
                $0.values.compactMap {
                    $0.coordinate.map {
                        .init($0)
                    }
                }
            }
        default: ()
        }
        return v
    }
}
