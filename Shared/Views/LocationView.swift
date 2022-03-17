//
//  LocationView.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var image: Image? = nil
    private let data: Location
    init(_ d: Location) {
        data = d
    }
    var body: some View {
        GeometryReader { geo in
            HStack {
                if image == nil {
                    EmptyView()
                } else {
                    image?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .clipped()
                }
            }.task {
                image = try? await LocationFetcher(
                    .init(from: data.coordinate),
                    size: geo.size
                ).fetch().map { .init(nativeImage: $0) }
            }.id(colorScheme)
        }
    }
}

extension CGSize {
    func padded(_ v: Int) -> Self {
        .init(width: width + (width * CGFloat(v)), height: height + (height * CGFloat(v)))
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(.mock)
    }
}

extension CLLocationCoordinate2D {
    init(from coordinate: Coordinate) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

