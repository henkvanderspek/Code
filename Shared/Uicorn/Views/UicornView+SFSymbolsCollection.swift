//
//  UicornView+SFSymbolsCollection.swift
//  Code
//
//  Created by Henk van der Spek on 04/06/2022.
//

import SwiftUI

extension UicornView {
    struct SFSymbolsCollection: View {
        private static let spacing = 2.0
        private static let cols = 3
        private let model: [Uicorn.SFSymbol] = .all
        private var columns: [GridItem] = .init(repeating: .init(.flexible(), spacing: spacing), count: cols)
        var body: some View {
            GeometryReader { geo in
                ScrollView {
                    SwiftUI.LazyVGrid(columns: columns, spacing: Self.spacing) {
                        ForEach(model, id: \.name) { s in
                            SwiftUI.Image(systemName: s.name)
                                .font(.system(size: geo.size.width / .init(Self.cols)))
                                .scaleEffect(0.5)
                                .frame(height: (geo.size.width / .init(Self.cols)))
                        }
                    }
                }
            }
        }
    }
}

struct SFSymbolsCollection_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.SFSymbolsCollection()
    }
}
