//
//  DatabaseView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/06/2022.
//

import SwiftUI

struct DatabaseView: View {
    @EnvironmentObject private var observer: DatabaseModelObserver
    @EnvironmentObject private var database: DatabaseController
    var body: some View {
        if observer.rootItem.id != observer.selectedItem.id, let e = database.entity(by: observer.selectedItem.id), let r = database.records(byEntity: observer.selectedItem.id) {
            ScrollView {
                VStack(spacing: 1) {
                    HStack(spacing: 1) {
                        ForEach(e.attributes, id: \.id) {
                            Text($0.name)
                                .lineLimit(1)
                                .padding(5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.callout.weight(.medium))
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
                                        .background(Color.gray.opacity(0.1))
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
}

struct CmsView_Previews: PreviewProvider {
    static var previews: some View {
        DatabaseView()
    }
}
