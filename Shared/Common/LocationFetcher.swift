//
//  LocationFetcher.swift
//  Code
//
//  Created by Henk van der Spek on 16/03/2022.
//

import MapKit

class LocationFetcher: NSObject {
    let coordinate: CLLocationCoordinate2D
    private let snapshotter: MKMapSnapshotter
    init(_ c: CLLocationCoordinate2D, size: CGSize) {
        coordinate = c
        snapshotter = MKMapSnapshotter(options: .init(from: coordinate, size: size))
    }
    func fetch() async throws -> NativeImage? {
        let s = try await snapshotter.start()
        let p = s.point(for: coordinate)
        return await s.image.withAnnotation(self, at: p)
    }
}

extension LocationFetcher: MKAnnotation {}

extension NativeImage {
    @MainActor
    func withAnnotation(_ annotation: MKAnnotation, at p: CGPoint) async -> NativeImage? {
    #if os(iOS)
        UIGraphicsBeginImageContextWithOptions(size, true, scale)
        draw(at: .zero)
        let s = CGSize(width: 40, height: 40)
        let x = p.x - s.width / 2
        let y = p.y - s.height / 2
        let a = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: .init())
        a.contentMode = .scaleAspectFit
        a.bounds = .init(origin: .zero, size: s)
        a.drawHierarchy(in: .init(origin: .init(x: x, y: y), size: s), afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    #elseif os(macOS)
        // TODO: We probably want to use catalyst anyway
        return self
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
