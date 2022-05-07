//
//  PropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI
import Combine

struct PropertiesView: SwiftUI.View {
    @Binding var view: JsonUI.View?
    private let style: ConfigurationStyle = .default
    var body: some SwiftUI.View {
        Text($view.wrappedValue?.name ?? "")
        Button {
            view?.type = .spacer
        } label: {
            Label("Update", systemImage: "wand.and.stars")
        }
    }
}

struct PropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesView(view: .constant(.init(.mock)))
    }
}
