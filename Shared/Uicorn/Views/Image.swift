//
//  Image.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import SwiftUI

extension UicornView {
    struct Image: View {
        @Binding var model: Uicorn.View.Image
        private var host: UicornHost
        @State private var cachedImage: SwiftUI.Image?
        init(_ m: Binding<Uicorn.View.Image>, host h: UicornHost) {
            _model = m
            host = h
        }
        var body: some View {
            switch $model.wrappedValue.type {
            case .remote:
                AsyncImage(url: .init(string: host.resolve($model.wrappedValue.value))) { phase in
                    if let image = phase.image {
                        createView(for: image, width: .infinity, height: .infinity)
                            .onAppear {
                                cachedImage = image
                            }
                    } else if let cachedImage = cachedImage {
                        createView(for: cachedImage, width: .infinity, height: .infinity)
                    } else if phase.error != nil {
                        SwiftUI.Rectangle()
                            .foregroundColor(.black)
                    } else {
                        SwiftUI.Rectangle()
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .system:
                SwiftUI.Image(systemName: model.value)
                    .foregroundColor(Color(model.fill ?? .system(.label)))
                    .font(.body.weight(.medium))
                    .imageScale(.large)
            }
        }
    }
}

private extension UicornView.Image {
    @ViewBuilder func createView(for image: SwiftUI.Image, width: CGFloat, height: CGFloat) -> some SwiftUI.View {
        SwiftUI.VStack(alignment: .center) {
            image
                .resizable()
                .scaledToFill()
                .id(UUID())
        }
        .frame(maxWidth: width, maxHeight: height)
        .clipped()
    }
}

struct Image_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Image(.constant(.init(type: .system, value: "mustache", fill: nil)), host: MockHost())
        UicornView.Image(.constant(.init(type: .remote, value: "https://images.unsplash.com/photo-1653624840011-5f74bdd7c1b9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1333&q=80", fill: nil)), host: MockHost())
    }
}
