//
//  PostHeaderView.swift
//  Code
//
//  Created by Henk van der Spek on 16/03/2022.
//

import SwiftUI

struct PostHeaderView: View {
    let title: String
    let author: String
    let padding: Double
    init(_ t: String, author a: String, padding p: Double = 16.0) {
        title = t
        author = a
        padding = p
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(.title, design: .serif))
                .padding(.horizontal, padding)
            ZStack {
                Text(author)
                    .font(.system(.caption2, design: .serif))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(.teal)
                    .cornerRadius(2)
                    .foregroundColor(.white)
            }.padding(.horizontal, padding)
        }
    }
}

struct PostHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PostHeaderView("My First Article", author: "Henk van der Spek")
    }
}
