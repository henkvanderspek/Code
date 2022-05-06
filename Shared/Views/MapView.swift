//
//  MapView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    private struct Item: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }
    let map: JsonUI.View.Map
    @State private var region: MKCoordinateRegion
    private let item: Item
    init(_ m: JsonUI.View.Map) {
        let c = CLLocationCoordinate2D(from: m.coordinate)
        map = m
        _region = State(initialValue: .init(center: c, latitudinalMeters: 800, longitudinalMeters: 800))
        item = .init(name: map.coordinate.title ?? "", coordinate: c)
    }
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [item]) { i in
            MapMarker(coordinate: i.coordinate)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        MapView(.mock)
    }
}

private extension CLLocationCoordinate2D {
    init(from other: JsonUI.View.Map.Coordinate) {
        self.init(latitude: other.latitude, longitude: other.longitude)
    }
}
