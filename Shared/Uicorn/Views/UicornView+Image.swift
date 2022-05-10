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
                            SwiftUI.VStack(alignment: .center) {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .id(UUID())
                            }
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                        } else if phase.error != nil {
                            Rectangle()
                                .foregroundColor(.black)
                        } else {
                            Rectangle()
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
        }
    }
}

struct UicornView_Image_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Image(.constant(.init(type: .remote, value: .init())), host: MockHost())
    }
}
