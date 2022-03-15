//
//  ImageView.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import SwiftUI

struct ImageView: View {
    let url: URL
    var body: some View {
        GeometryReader { geo in
            AsyncImage(url: url) { image in
                VStack(alignment: .center) {
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

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: .mock)
            .frame(height: 200)
    }
}
