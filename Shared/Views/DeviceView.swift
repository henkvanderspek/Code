//
//  DeviceView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI

struct DeviceView: View {
    let apps: [JsonUI.App]
    @Binding var selectedItem: TreeView.Item
    var body: some View {
        if let s = apps.compactMap({ $0.screens.first { $0.id == selectedItem.rootId } }).first {
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
        DeviceView(apps: [.mock], selectedItem: .constant(.mock))
    }
}
