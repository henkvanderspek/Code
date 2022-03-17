//
//  IssueView.swift
//  Code
//
//  Created by Henk van der Spek on 16/03/2022.
//

import SwiftUI

struct IssueView: View {
    let issue: Issue
    let spacing: Double
    let padding: Double
    init(_ i: Issue, spacing s: Double, padding p: Double) {
        issue = i
        spacing = s
        padding = p
    }
    var body: some View {
        ZStack {
            LazyVGrid(columns: .init(repeating: .init(), count: 1), alignment: .leading, spacing: spacing) {
                ForEach(Array(issue.articles.enumerated()), id: \.offset) { i, e in
                    VStack(spacing: spacing) {
                        if i != 0 {
                            Color
                                .teal
                                .frame(height: 1)
                                .padding(.horizontal, padding)
                        }
                        ArticleView(e, padding: padding)
                    }
                }
            }
        }
    }
}

struct IssueView_Previews: PreviewProvider {
    static var previews: some View {
        IssueView(.mock, spacing: 24.0, padding: 16.0)
    }
}
