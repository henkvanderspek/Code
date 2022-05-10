//
//  UicornView+UnsplashCollection.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import SwiftUI

extension UicornView {
    struct UnsplashCollection: View {
        let query: String
        let count: Int
        @Binding var view: Uicorn.View?
        @EnvironmentObject var backendController: Backend.Controller
        @State private var images: [Backend.Images.Item]?
        private var host: UicornHost
        private static let spacing = 2.0
        private static let cols = 3
        private var columns: [GridItem] = .init(repeating: .init(.flexible(), spacing: spacing), count: cols)
        init(query q: String, count c: Int, view v: Binding<Uicorn.View?>, host h: UicornHost) {
            query = q
            count = c
            _view  = v
            host = h
        }
        var body: some View {
            SwiftUI.ZStack {
                if let i = images {
                    GeometryReader { geo in
                        ScrollView {
                            SwiftUI.LazyVGrid(columns: columns, spacing: Self.spacing) {
                                ForEach(i) { image in
                                    if let v = Binding($view) {
                                        UicornView(v) {
                                            $0.replacingOccurrences(of: "{{url}}", with: image.thumb)
                                        }
                                        .frame(height: (geo.size.width / .init(Self.cols)))
                                    } else {
                                        SwiftUI.Text(image.id.uuidString)
                                    }
                                }
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.clear)
                                    .onAppear {
                                        appendImages()
                                    }
                            }
                            ProgressView()
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .onAppear() {
                appendImages()
            }
        }
    }
}

extension UicornView.UnsplashCollection {
    func appendImages() {
        Task {
            guard let items = await backendController.fetchImages(query, count: count)?.items else { return }
            var current = images ?? []
            current.append(contentsOf: items)
            images = current
        }
    }
}

struct UicornView_UnsplashCollection_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.UnsplashCollection(query: "pug", count: 10, view: .constant(.empty), host: MockHost())
    }
}
