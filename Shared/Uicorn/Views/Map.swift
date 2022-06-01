//
//  View+Map.swift
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
            MapKit.Map(coordinateRegion: $model.location.coordinateRegion, annotationItems: [model.location.annotationItem]) {
                MapMarker(coordinate: $0.coordinate)
            }
        }
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Map(.constant(.init(location: .mock)))
    }
}

extension Uicorn.Location {
    var coordinateRegion: MKCoordinateRegion {
        get {
            .init(center: .init(coordinate), latitudinalMeters: 800, longitudinalMeters: 800)
        }
        set {
            coordinate = .init(newValue.center)
        }
    }
    var annotationItem: UicornView.Map.AnnotationItem {
        .init(name: name, coordinate: .init(coordinate))
    }
}
