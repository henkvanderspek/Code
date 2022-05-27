//
//  VGroup.swift
//  macOS
//
//  Created by Henk van der Spek on 27/05/2022.
//

import SwiftUI

struct VGroup<Content: View>: View {
    @ViewBuilder let content: ()->Content
    var body: some View {
        Group(axis: .vertical, content: content)
    }
}

struct VGroup_Previews: PreviewProvider {
    static var previews: some View {
        VGroup {
            Color.yellow
        }
    }
}
