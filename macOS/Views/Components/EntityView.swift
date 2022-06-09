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
    init(_ e: Binding<Uicorn.Database.Entity>) {
        _entity = e
        values = .init(repeating: nil, count: e.wrappedValue.attributes.count)
    }
    var body: some View {
        ScrollView {
            Form {
                ForEach(Array(entity.attributes.enumerated()), id: \.offset) { i, e in
                    VGroup {
                        Header(e.name, font: .body, fontWeight: .medium)
                        TextField(e.name, text: value(at: i))
                    }
                }
            }
            .padding()
            .labelsHidden()
        }
    }
}

private extension EntityView {
    func value(at i: Int) -> Binding<String> {
        .init(
            get: {
                return values[i] ?? ""
            },
            set: {
                values[i] = $0
            }
        )
    }
}

struct EntityView_Previews: PreviewProvider {
    static var previews: some View {
        EntityView(.constant(.mock))
    }
}
