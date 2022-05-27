//
//  Group.swift
//  macOS
//
//  Created by Henk van der Spek on 27/05/2022.
//

import SwiftUI

struct Group<Content: View>: View {
    let axis: Axis
    @ViewBuilder let content: ()->Content
    var body: some View {
        container
            .padding(.vertical, 2)
            //.background(Color.orange)
    }
    @ViewBuilder private var container: some View {
        if axis == .horizontal {
            HStack {
                content()
            }
        } else {
            VStack(alignment: .leading) {
                content()
            }
        }
    }
}

struct Group_Previews: PreviewProvider {
    static var previews: some View {
        Group(axis: .horizontal) {
            Color.yellow
        }
    }
}
