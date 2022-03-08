//
//  LiveHeaderView.swift
//  Code
//
//  Created by Henk van der Spek on 01/03/2022.
//

import SwiftUI

struct LiveHeader {
    struct Image {
        let url: URL
        let description: String
        let source: String
    }
    let superTitle: String
    let title: String
    let body: String
    let image: Image
}

struct LiveHeaderView: View {
    let viewModel: LiveHeader
    private let padding = CGFloat(16)
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        LiveView()
                        Text(viewModel.superTitle)
                            .foregroundColor(.red)
                            .font(.system(.footnote, design: .serif))
                    }
                    Text(viewModel.title).font(.system(.title, design: .serif))
                    Text(viewModel.body).font(.system(.body, design: .serif))
                    
                    ZStack {
                        AsyncImage(url: viewModel.image.url)
                    }
                        .frame(width: geo.size.width - (2 * padding), height: 200)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.image.description)
                            .font(.system(.caption, design: .serif))
                        Text("*\(viewModel.image.source)*")
                            .font(.system(.caption2, design: .serif))
                            .foregroundColor(.gray)
                    }
                }
                .padding(padding)
            }
        }
    }
}

struct LiveHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LiveHeaderView(viewModel: .mock)
    }
}

extension LiveHeader {
    static var mock: Self {
        .init(superTitle: "Supertitle", title: "Title", body: "Body", image: .mock)
    }
}

extension LiveHeader.Image {
    static var mock: Self {
        .init(url: .mock, description: "Description", source: "Source")
    }
}

extension URL {
    static var mock: Self {
        .init(string: "https://images.unsplash.com/photo-1592554722895-f54ab5e5c9b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80")!
    }
}
