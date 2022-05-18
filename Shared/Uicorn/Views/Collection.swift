//
//  Collection.swift
//  Uicorn
//
//  Created by Henk van der Spek on 10/05/2022.
//

import SwiftUI

extension Uicorn {
    static let defaultUnsplashCollectionQuery = "pug"
    static let defaultUnsplashCollectionCount = 20
}

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
                // TODO: rewrite this in a generic (vertical) grid with optional lazy loader
                UnsplashCollection(query: Binding($model.query, default: Uicorn.defaultUnsplashCollectionQuery), count: Binding($model.count, default: Uicorn.defaultUnsplashCollectionCount), view: $model.view, host: host)
            }
        }
    }
}

struct UicornView_Collection_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Collection(.constant(.init(type: .unsplash, parameters: [:], view: nil)), host: MockHost())
    }
}
