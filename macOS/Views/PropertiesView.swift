//
//  PropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI
import Combine

struct PropertiesView: SwiftUI.View {
    @Binding var view: JsonUI.View
    private let style: ConfigurationStyle = .default
    var body: some SwiftUI.View {
        switch view.type {
        case .empty:
            EmptyView()
        default:
            Text($view.wrappedValue.name)
            Button {
                switch view.type {
                case .text:
                    view.type = .spacer
                default:
                    view.type = .text(.init(value: "🐶"))
                }
            } label: {
                Label("Update", systemImage: "wand.and.stars")
            }
        }
    }
}

struct PropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesView(view: .constant(.mock))
    }
}
