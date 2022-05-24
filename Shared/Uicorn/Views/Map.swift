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
        var body: some View {
            MapKit.Map(mapRect: .constant(.world))
        }
    }
}

struct View_Map_Previews: PreviewProvider {
    static var previews: some View {
        UicornView.Map()
    }
}
