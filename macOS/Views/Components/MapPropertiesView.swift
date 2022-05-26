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
        EmptyView()
    }
}

struct MapPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        MapPropertiesView(.constant(.init()))
    }
}
