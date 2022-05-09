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
        init(_ m: Binding<Uicorn.View.Image>) {
            _model = m
        }
        var body: some View {
            switch $model.wrappedValue.type {
            case .remote:
                GeometryReader { geo in
                    AsyncImage(url: .init(string: $model.wrappedValue.value)) { image in
                        SwiftUI.VStack(alignment: .center) {
                            image
                                .resizable()
                                .scaledToFill()
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                    } placeholder: {
                        Rectangle()
                            .foregroundColor(.white)
                    }.frame(width: geo.size.width, height: geo.size.height)
                }
            }
        }
    }
}

struct UicornView_Image_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Image(.constant(.init(type: .remote, value: .init())))
    }
}
