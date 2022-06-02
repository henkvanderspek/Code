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
        @State private var cachedImage: SwiftUI.Image?
        init(_ m: Binding<Uicorn.View.Image>) {
            _model = m
        }
        var body: some View {
            switch $model.wrappedValue.type {
            case .remote:
                AsyncImage(url: .init(string: $model.wrappedValue.remote.url)) { phase in
                    if let image = phase.image {
                        createView(for: image)
                            .onAppear {
                                cachedImage = image
                            }
                    } else if let cachedImage = cachedImage {
                        createView(for: cachedImage)
                    } else if phase.error != nil {
                        SwiftUI.Rectangle()
                            .foregroundColor(.black)
                    } else {
                        SwiftUI.Rectangle()
                            .foregroundColor(.init(.background))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .onAppear {
                    print("Appeared: \($model.wrappedValue.remote.url.suffix(10))")
                }
            case .system:
                $model.system.wrappedValue.image
            }
        }
    }
}

private extension Uicorn.View.Image.System {
    var image: some View {
        SwiftUI.Image(systemName: name)
            .foregroundColor(Color(fill ?? .system(.label)))
            .font(.init(.init(type: type, weight: weight, design: .default, leading: .standard)))
            .imageScale(.init(scale))
    }
}

private extension UicornView.Image {
    @ViewBuilder func createView(for image: SwiftUI.Image) -> some SwiftUI.View {
        Color
            .clear
            .overlay {
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .id(UUID())
            }
    }
}

struct Image_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Image(.constant(.randomRemote))
        UicornView.Image(.constant(.randomSystem(fill: nil)))
    }
}
