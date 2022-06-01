//
//  MapPropertiesView.swift
//  Code
//
//  Created by Henk van der Spek on 26/05/2022.
//

import SwiftUI

struct MapPropertiesView: View {
    @Binding var model: Uicorn.View.Map
    init(_ m: Binding<Uicorn.View.Map>) {
        _model = m
    }
    var body: some View {
        Section {
            TextFieldView(value: $model.location.coordinate.latitude.string, header: "Latitude")
            TextFieldView(value: $model.location.coordinate.longitude.string, header: "Longitude")
        }.labelsHidden()
    }
}

struct MapPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        MapPropertiesView(.constant(.init(location: .mock)))
    }
}

extension Double {
    var string: String {
        get {
            .init(self)
        }
        set {
            self = .init(newValue) ?? 0.0
        }
    }
}
