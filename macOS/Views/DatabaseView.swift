//
//  DatabaseView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/06/2022.
//

import SwiftUI

struct DatabaseView: View {
    var selectedEntityId: Binding<String?>
    @EnvironmentObject private var database: DatabaseController
    @State private var isAddActive: Bool = false
    @State private var currentRecord: Uicorn.Database.Record = .empty
    @State private var uuid: UUID = .init()
    var body: some View {
        ZStack {
            if let id = selectedEntityId.wrappedValue, let e = database.entity(by: id), let r = database.records(byEntity: id) {
                ScrollView {
                    HStack {
                        Text(e.name)
                            .font(.title2)
                            .bold()
                        Spacer()
                        Button {
                            currentRecord = .init(rowId: r.count, e)
                            isAddActive = true
                        } label: {
                            Label("Add", systemImage: "plus")
                                .font(.title2)
                                .labelStyle(.iconOnly)
                        }
                        .buttonStyle(.borderless)
                        .sheet(isPresented: $isAddActive) {
                            ZStack {
                                EntityView(entity(e), record: $currentRecord)
                                    .frame(width: 300)
                                    .frame(maxHeight: 300)
                            }
                            .toolbar {
                                ToolbarItemGroup(placement: .cancellationAction) {
                                    Button {
                                        isAddActive = false
                                    } label: {
                                        Text("Cancel")
                                    }
                                }
                                ToolbarItemGroup(placement: .confirmationAction) {
                                    Button {
                                        isAddActive = false
                                        database.store(entityId: id, currentRecord)
                                        uuid = .init()
                                    } label: {
                                        Text("Save")
                                    }
                                }
                            }
                        }
                    }
                    VStack(spacing: 1) {
                        HStack(spacing: 1) {
                            ForEach(e.attributes, id: \.id) {
                                Text($0.name)
                                    .lineLimit(1)
                                    .padding(5)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                            }
                        }
                        LazyVGrid(columns: [.init()], alignment: .leading, spacing: 1) {
                            ForEach(r, id: \.rowId) { record in
                                HStack(spacing: 1) {
                                    ForEach(record.values, id: \.id) {
                                        Text($0.string)
                                            .lineLimit(1)
                                            .padding(5)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        //.background(Color.gray.opacity(0.1))
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            } else {
                EmptyView()
            }
        }
        .id(uuid)
    }
}

struct CmsView_Previews: PreviewProvider {
    static var previews: some View {
        DatabaseView(selectedEntityId: .constant(.entityPlaceId))
            .environmentObject(DatabaseController(configuration: .dev))
    }
}

private extension DatabaseView {
    func entity(_ e: Uicorn.Database.Entity) -> Binding<Uicorn.Database.Entity> {
        .init(
            get: {
                e
            },
            set: { _ in
                fatalError()
            }
        )
    }
}

extension Uicorn.Database.Record {
    static var empty: Self {
        .init(rowId: 0, values: [])
    }
}
