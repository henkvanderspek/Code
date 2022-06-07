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
                        .environmentObject(DatabaseCollectionValueProvider(records))
                }
            }
//            // TODO: From here is implementation detail that should be decided by the user
//            // TODO: For now we are hacking it like this
//            ScrollView {
//                LazyVGrid(columns: [.init(), .init()]) {
//                    if let records: [Uicorn.Database.Record] = database.records(byEntity: $entity.wrappedValue) {
//                        ForEach(records, id: \.rowId) { record in
//                            SwiftUI.VStack(spacing: 2) {
//                                ForEach(record.values, id: \.id) {
//                                    switch $0.type {
//                                    case let .string(s):
//                                        SwiftUI.Text(s)
//                                    case let .coordinate(c):
//                                        Map(.constant(.init(location: .init(name: "Foo", coordinate: c))))
//                                            .frame(height: 200)
//                                    default:
//                                        fatalError()
//                                    }
//                                }
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            }
//                            .frame(maxWidth: .infinity)
//                        }
//                    }
//                }
//                .padding()
//            }
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
        return v
    }
}
