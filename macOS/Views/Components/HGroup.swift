//
//  HGroup.swift
//  macOS
//
//  Created by Henk van der Spek on 27/05/2022.
//

import SwiftUI

struct HGroup<Content: View>: View {
    @ViewBuilder let content: ()->Content
    var body: some View {
        Group(axis: .horizontal, content: content)
    }
}

struct HGroup_Previews: PreviewProvider {
    static var previews: some View {
        HGroup {
            Color.yellow
        }
    }
}
