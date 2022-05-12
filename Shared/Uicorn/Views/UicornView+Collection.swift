//
//  UicornView+Collection.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import SwiftUI

extension UicornView {
    struct Collection: View {
        @Binding var model: Uicorn.View.Collection
        private var host: UicornHost
        init(_ m: Binding<Uicorn.View.Collection>, host h: UicornHost) {
            _model = m
            host = h
        }
        var body: some View {
            switch $model.wrappedValue.type {
            case .unsplash:
                UnsplashCollection(query: model.query ?? "pug", count: model.count ?? 100, view: $model.view, host: host)
                    .id(model.query)
            }
        }
    }
}

struct UicornView_Collection_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Collection(.constant(.init(type: .unsplash, parameters: [:], view: nil)), host: MockHost())
    }
}
