//
//  EntityView.swift
//  macOS
//
//  Created by Henk van der Spek on 09/06/2022.
//

import SwiftUI

struct EntityView: View {
    @Binding var entity: Uicorn.Database.Entity
    @State var values: [String?]
    // TODO: store record
    init(_ e: Binding<Uicorn.Database.Entity>) {
        _entity = e
        values = .init(repeating: nil, count: e.wrappedValue.attributes.count)
    }
    var body: some View {
        ScrollView {
            Form {
                ForEach(Array(entity.attributes.enumerated()), id: \.offset) { i, e in
                    VGroup {
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
                values[i] ?? ""
            },
            set: {
                values[i] = $0
            }
        )
    }
    func coordinate(at i: Int) -> Binding<Uicorn.Coordinate> {
        .init(
            get: {
                guard let s = values[i], let d = s.data(using: .utf8) else { return .zero }
                return (try? JSONDecoder().decode(Uicorn.Coordinate.self, from: d)) ?? .zero
            },
            set: {
                guard let d = try? JSONEncoder().encode($0) else { return }
                guard let s = String(data: d, encoding: .utf8) else { return }
                values[i] = s
            }
        )
    }
}

struct EntityView_Previews: PreviewProvider {
    static var previews: some View {
        EntityView(.constant(.mock))
    }
}
