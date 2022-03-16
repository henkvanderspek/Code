//
//  LocationFetcher.swift
//  Code
//
//  Created by Henk van der Spek on 16/03/2022.
//

#if os(iOS)
import UIKit
typealias NativeImage = UIImage
#elseif os(macOS)
import AppKit
typealias NativeImage = NSImage
#endif
import MapKit

class LocationFetcher {
    private let snapshotter: MKMapSnapshotter
    private var image: NativeImage?
    init(_ coordinate: CLLocationCoordinate2D, size: CGSize) {
        snapshotter = MKMapSnapshotter(options: .init(from: coordinate, size: size))
    }
    func fetch() async throws -> NativeImage? {
        guard image == nil else { return image }
        let s = try await snapshotter.start()
        image = s.image
        // TODO: Add pin using SF Symbol "mappin.circle.fill"
    #if os(iOS)
        return s.image
    #elseif os(macOS)
        return s.image
    #endif
    }
}

extension MKMapSnapshotter.Options {
    convenience init(from coordinate: CLLocationCoordinate2D, size s: CGSize) {
        self.init()
        size = s
        region = MKCoordinateRegion(center: coordinate, span: .init())
    }
}
