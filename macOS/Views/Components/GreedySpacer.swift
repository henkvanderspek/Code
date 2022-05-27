//
//  GreedySpacer.swift
//  Code
//
//  Created by Henk van der Spek on 24/05/2022.
//

import SwiftUI

struct GreedySpacer: View {
    var body: some View {
        Spacer()
            .frame(maxWidth: .infinity, minHeight: 10)
            .padding(.leading, 5)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        GreedySpacer()
    }
}
