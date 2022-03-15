//
//  LocationView.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import SwiftUI
import MapKit

struct LocationView: View {
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
                    data.coordinate,
                    size: geo.size
                ).fetch()
            }
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

struct LocationFetcher {
    typealias CompletionHandler = (Image?)->()
    private let snapshotter: MKMapSnapshotter
    init(_ coordinate: Coordinate, size: CGSize) {
        snapshotter = MKMapSnapshotter(options: .init(from: coordinate, size: size))
    }
    func fetch() async throws -> Image? {
        let s = try await snapshotter.start()
    #if os(iOS)
        return .init(uiImage: s.image)
    #elseif os(macOS)
        return .init(nsImage: s.image)
    #endif
    }
}

extension MKMapSnapshotter.Options {
    convenience init(from coordinate: Coordinate, size s: CGSize) {
        self.init()
        size = s
        region = MKCoordinateRegion(center: .init(from: coordinate), span: .init())
    }
}

extension CLLocationCoordinate2D {
    init(from coordinate: Coordinate) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
