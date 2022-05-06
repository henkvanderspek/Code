//
//  IssueDateView.swift
//  Code
//
//  Created by Henk van der Spek on 16/03/2022.
//

import SwiftUI

struct IssueDateView: View {
    let date: Date
    init(_ d: Date) {
        date = d
    }
    var body: some View {
        Text(CustomFormatter.relativeString(from: date))
            .font(.system(.footnote, design: .serif))
            .fontWeight(.semibold)
            .padding(4)
            .background(.black)
            .foregroundColor(.white)
    }
}

struct IssueDateView_Previews: PreviewProvider {
    static var previews: some View {
        IssueDateView(.now)
    }
}
