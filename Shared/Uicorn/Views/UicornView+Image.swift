//
//  UicornView+Image.swift
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
                GeometryReader { geo in
                    AsyncImage(url: .init(string: host.resolve($model.wrappedValue.value))) { phase in
                        if let image = phase.image {
                            createView(for: image, width: geo.size.width, height: geo.size.height)
                                .onAppear {
                                    cachedImage = image
                                }
                        } else if let cachedImage = cachedImage {
                            createView(for: cachedImage, width: geo.size.width, height: geo.size.height)
                        } else if phase.error != nil {
                            SwiftUI.Rectangle()
                                .foregroundColor(.black)
                        } else {
                            SwiftUI.Rectangle()
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            case .system:
                SwiftUI.Image(systemName: model.value)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color(model.fill ?? .system(.label)))
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
        .frame(width: width, height: height)
        .clipped()
    }
}

struct UicornView_Image_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Image(.constant(.init(type: .remote, value: .init(), fill: nil)), host: MockHost())
    }
}
