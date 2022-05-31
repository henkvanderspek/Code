//
//  UnsplashCollection.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import SwiftUI

extension UicornView {
    struct UnsplashCollection: View {
        @Binding var query: String
        @Binding var count: Int
        @Binding var view: Uicorn.View?
        @EnvironmentObject var backendController: Backend.Controller
        @State private var images: [Backend.Images.Item]?
        private static let spacing = 2.0
        private static let cols = 3
        private var columns: [GridItem] = .init(repeating: .init(.flexible(), spacing: spacing), count: cols)
        private let valueProvider: ValueProvider?
        init(query q: Binding<String>, count c: Binding<Int>, view v: Binding<Uicorn.View?>, valueProvider vp: ValueProvider? = nil) {
            _query = q
            _count = c
            _view  = v
            valueProvider = vp
        }
        var body: some View {
            SwiftUI.ZStack {
                GeometryReader { geo in
                    if let i = images {
                        ScrollView {
                            SwiftUI.LazyVGrid(columns: columns, spacing: Self.spacing) {
                                ForEach(i) { image in
                                    if let v = Binding($view) {
                                        UicornView(v, valueProvider: valueProvider)
                                        // TODO: Resolver environment object
//                                            switch context {
//                                            case .`default`:
//                                                return value.replacingOccurrences(of: "{{url}}", with: image.thumb)
//                                            case .sheet:
//                                                return value.replacingOccurrences(of: "{{url}}", with: image.regular)
                                        .frame(height: (geo.size.width / .init(Self.cols)))
                                    } else {
                                        SwiftUI.Text(image.id.uuidString)
                                    }
                                }
                                SwiftUI.Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.clear)
                                    .onAppear {
                                        guard i.count >= Uicorn.defaultUnsplashCollectionCount else { return }
                                        appendImages()
                                    }
                            }
                            if !i.isEmpty {
                                if i.count < Uicorn.defaultUnsplashCollectionCount {
                                    progressView
                                }
                            } else {
                                SwiftUI.VStack {
                                    SwiftUI.Text("Failed to fetch images 😱")
                                    SwiftUI.Button("Retry") {
                                        appendImages()
                                    }
                                }
                                .frame(height: geo.size.height)
                            }
                        }
                    } else {
                        progressView
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
            }
            .onChange(of: query) { _ in
                refreshImages()
            }
            .onChange(of: count) { _ in
                refreshImages()
            }
            .onAppear() {
                appendImages()
            }
        }
    }
}

private extension UicornView.UnsplashCollection {
    func refreshImages() {
        images = nil
        appendImages()
    }
    func appendImages() {
        Task {
            let items = await backendController.fetchImages($query.wrappedValue, count: $count.wrappedValue)?.items
            var current = images ?? []
            current.append(contentsOf: items ?? [])
            images = current
        }
    }
    var progressView: some View {
        return ProgressView()
        #if os(macOS)
            .scaleEffect(0.5)
        #endif
    }
}

struct UnsplashCollection_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.UnsplashCollection(query: .constant("pug"), count: .constant(10), view: .constant(.empty))
    }
}
