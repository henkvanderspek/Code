//
//  DeviceView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct DeviceView: View {
    @Binding var app: JsonUI.App
    @Binding var selectedItem: TreeView.Item
    var body: some View {
        if let s = app.screens.first(where: { $0.id == selectedItem.rootId }) {
            JsonUIView(s.view)
                .frame(width: 320, height: 568)
                .background(Color.white)
                .cornerRadius(15.0)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 1, y: 1)
        } else {
            Text("No screen selected")
        }
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView(app: .constant(.mock), selectedItem: .constant(.mock))
    }
}
