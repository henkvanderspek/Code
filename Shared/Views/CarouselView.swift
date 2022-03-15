//
//  CarouselView.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import SwiftUI

struct CarouselView: View {
    let items: [CarouselItem]
    var body: some View {
        TabView {
            ForEach(items) { item in
                switch item.type {
                case let .location(loc):
                    LocationView(loc)
                case let .image(url):
                    ImageView(url: url)
                }
            }
        }
    #if os(iOS)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    #endif
    }
}

extension CarouselItem: Identifiable {}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(
            items: [
                .init(type: .location(.zanzibarBeachclub))
            ]
        )
    }
}
