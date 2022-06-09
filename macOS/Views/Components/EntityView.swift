//
//  EntityView.swift
//  macOS
//
//  Created by Henk van der Spek on 09/06/2022.
//

import SwiftUI

struct EntityView: View {
    @Binding var entity: Uicorn.Database.Entity
    @Binding var record: Uicorn.Database.Record
    init(_ e: Binding<Uicorn.Database.Entity>, record r: Binding<Uicorn.Database.Record>) {
        _entity = e
        _record = r
    }
    var body: some View {
        ScrollView {
            Form {
                ForEach(Array(entity.attributes.enumerated()), id: \.offset) { i, e in
                    LazyVGrid(columns: .init(repeating: .init(.adaptive(minimum: 80)), count: 2), alignment: .leading) {
                        switch e.type {
                        case .string:
                            header(e.name)
                            TextField(e.name, text: string(at: i))
                        case .coordinate:
                            let c = coordinate(at: i)
                            header("Latitude")
                            TextField(e.name, value: c.latitude, format: .number.locale(.init(identifier: "US")))
                            header("Longitude")
                            TextField(e.name, value: c.longitude, format: .number.locale(.init(identifier: "US")))
                        case .int, .double, .boolean:
                            fatalError()
                        }
                        
                    }
                }
            }
            .padding()
            .labelsHidden()
        }
    }
}

private extension EntityView {
    func header(_ s: String) -> some View {
        Header(s, font: .body, fontWeight: .medium)
    }
    func string(at i: Int) -> Binding<String> {
        .init(
            get: {
                record.values[i].string
            },
            set: {
                record.values[i] = record.values[i].modified($0)
            }
        )
    }
    func coordinate(at i: Int) -> Binding<Uicorn.Coordinate> {
        .init(
            get: {
                record.values[i].coordinate ?? .zero
            },
            set: {
                record.values[i] = record.values[i].modified($0)
            }
        )
    }
}

struct EntityView_Previews: PreviewProvider {
    static var previews: some View {
        EntityView(.constant(.mock), record: .constant(.init(.mock)))
    }
}

extension Uicorn.Database.Record {
    init(rowId id: Int = 0, _ e: Uicorn.Database.Entity) {
        rowId = id
        values = e.attributes.map { .init($0) }
    }
}

extension Uicorn.Database.Record.Value {
    init(_ a: Uicorn.Database.Attribute) {
        id = .unique
        attributeId = a.id
        type = .init(a.type)
    }
    func modified(_ v: String) -> Self {
        .init(id: id, attributeId: attributeId, type: .string(v))
    }
    func modified(_ v: Uicorn.Coordinate) -> Self {
        .init(id: id, attributeId: attributeId, type: .coordinate(v))
    }
}

extension Uicorn.Database.Record.Value.`Type` {
    init(_ t: Uicorn.Database.Attribute.`Type`) {
        switch t {
        case .boolean: self = .boolean(.init())
        case .double: self = .double(.init())
        case .int: self = .int(.init())
        case .string: self = .string(.init())
        case .coordinate: self = .coordinate(.zero)
        }
    }
}
