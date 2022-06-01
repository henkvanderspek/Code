//
//  Coordinate+MapKit.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import MapKit

extension CLLocationCoordinate2D {
    init(_ c: Uicorn.Coordinate) {
        self.init(latitude: c.latitude, longitude: c.longitude)
    }
}

extension Uicorn.Coordinate {
    convenience init(_ c: CLLocationCoordinate2D) {
        self.init(c.latitude, c.longitude)
    }
}
