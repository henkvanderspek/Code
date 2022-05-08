//
//  PropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct PropertiesView: View {
    @Binding var view: Uicorn.View
    var body: some View {
        switch view.type {
        case .empty:
            EmptyView()
        default:
            Text($view.wrappedValue.title)
            Button {
                switch view.type {
                case .text:
                    $view.type.wrappedValue = .spacer
                default:
                    $view.type.wrappedValue = .text(.init("🐶"))
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
