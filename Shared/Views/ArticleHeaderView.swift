//
//  ArticleHeaderView.swift
//  Code
//
//  Created by Henk van der Spek on 16/03/2022.
//

import SwiftUI

struct ArticleHeaderView: View {
    let article: Article
    let padding: Double
    init(_ a: Article, padding p: Double = 16.0) {
        article = a
        padding = p
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(article.title)
                .font(.system(.title, design: .serif))
                .padding(.horizontal, padding)
            HStack {
                Text(article.published, style: .date)
                    .font(.system(.footnote, design: .serif))
                Text(article.author)
                    .font(.system(.caption, design: .serif))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(.teal)
                    .foregroundColor(.init(nativeColor: .background))
                    .cornerRadius(2)
                    .foregroundColor(.white)
            }.padding(.horizontal, padding)
        }
    }
}

struct PostHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleHeaderView(.mock)
    }
}
