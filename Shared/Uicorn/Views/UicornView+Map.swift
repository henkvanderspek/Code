//
//  UicornView+Map.swift
//  Code
//
//  Created by Henk van der Spek on 24/05/2022.
//

import SwiftUI
import MapKit

extension UicornView {
    struct Map: View {
        struct AnnotationItem: Identifiable {
            let id = UUID()
            let name: String
            let coordinate: CLLocationCoordinate2D
        }
        @Binding var model: Uicorn.View.Map
        init(_ m: Binding<Uicorn.View.Map>) {
            _model = m
        }
        var body: some View {
            MapKit.Map(coordinateRegion: $model.coordinateRegion, annotationItems: model.annotations.map { AnnotationItem($0) }) {
                MapMarker(coordinate: $0.coordinate)
            }
        }
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Map(.constant(.mock))
    }
}

extension Uicorn.View.Map {
    var coordinateRegion: MKCoordinateRegion {
        get {
            .init(annotations.map { .init($0.coordinate) })?.increased(0.025) ?? .init()
        }
        set {}
    }
}

extension UicornView.Map.AnnotationItem {
    init(_ l: Uicorn.Location) {
        name = l.name
        coordinate = .init(l.coordinate)
    }
}

extension MKCoordinateRegion {
    init?(_ coordinates: [CLLocationCoordinate2D]) {
        // first create a region centered around the prime meridian
        let primeRegion = region(for: coordinates, transform: { $0 }, inverseTransform: { $0 })
        // next create a region centered around the 180th meridian
        let transformedRegion = region(for: coordinates, transform: transform, inverseTransform: inverseTransform)
        // return the region that has the smallest longitude delta
        if let a = primeRegion, let b = transformedRegion, let min = [a, b].min(by: { $0.span.longitudeDelta < $1.span.longitudeDelta }) {
            self = min
        } else if let a = primeRegion {
            self = a
        } else if let b = transformedRegion {
            self = b
        } else {
            return nil
        }
    }
    func increased(_ d: CLLocationDegrees) -> Self {
        .init(center: center, span: span.increased(d, d))
    }
    func increased(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees) -> Self {
        .init(center: center, span: span.increased(lat, lon))
    }
}

extension MKCoordinateSpan {
    func increased(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees) -> Self {
        .init(latitudeDelta: latitudeDelta + lat, longitudeDelta: longitudeDelta + lon)
    }
}

// Latitude -180...180 -> 0...360
private func transform(c: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
    if c.longitude < 0 { return .init(latitude: c.latitude, longitude: 360 + c.longitude) }
    return c
}

// Latitude 0...360 -> -180...180
private func inverseTransform(c: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
    if c.longitude > 180 { return CLLocationCoordinate2DMake(c.latitude, -360 + c.longitude) }
    return c
}

private typealias Transform = (CLLocationCoordinate2D) -> (CLLocationCoordinate2D)

private func region(for coordinates: [CLLocationCoordinate2D], transform: Transform, inverseTransform: Transform) -> MKCoordinateRegion? {
    
    // handle empty array
    guard !coordinates.isEmpty else { return nil }
    
    // handle single coordinate
    guard coordinates.count > 1 else {
        return MKCoordinateRegion(center: coordinates[0], span: .init(latitudeDelta: 1, longitudeDelta: 1))
    }
    
    let transformed = coordinates.map(transform)
    
    // find the span
    let minLat = transformed.min { $0.latitude < $1.latitude }!.latitude
    let maxLat = transformed.max { $0.latitude < $1.latitude }!.latitude
    let minLon = transformed.min { $0.longitude < $1.longitude }!.longitude
    let maxLon = transformed.max { $0.longitude < $1.longitude }!.longitude
    
    let span = MKCoordinateSpan(latitudeDelta: maxLat - minLat, longitudeDelta: maxLon - minLon)
    
    // find the center of the span
    let center = inverseTransform(.init(latitude: (maxLat - span.latitudeDelta / 2), longitude: maxLon - span.longitudeDelta / 2))
    
    return .init(center: center, span: span)
}
