//
//  PostView.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import SwiftUI

struct PostView: View {
    let post: Post
    let padding: Double
    init(_ p: Post, padding pa: Double = 16.0) {
        post = p
        padding = pa
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(post.title)
                .font(.system(.largeTitle, design: .serif))
                .padding(.horizontal, padding)
            ZStack {
                Text(post.date, style: .date)
                    .font(.system(.footnote, design: .serif))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(.teal)
                    .cornerRadius(2)
                    .foregroundColor(.white)
            }.padding(.horizontal, padding)
            ForEach(post.items) {
                $0.view(padding: padding)
            }
        }
    }
}

private extension Post.Item {
    func view(padding: Double) -> AnyView {
        switch type {
        case let .paragraph(s):
            return AnyView(
                Text(s)
                    .font(.system(.body, design: .serif))
                    .padding(.horizontal, padding)
            )
        case let .image(u, c):
            return AnyView(
                VStack(alignment: .leading) {
                    HStack {
                        ImageView(url: u)
                    }.frame(height: 400)
                    if let c = c {
                        Text(c)
                            .font(.system(.caption2, design: .serif))
                            .padding(.horizontal, padding * 2)
                    }
                }
            )
        case let .location(co, c):
            return AnyView(
                VStack {
                    LocationView(.init(title: "", coordinate: co))
                        .frame(height: 300)
                    if let c = c {
                        Text(c)
                            .font(.system(.caption2, design: .serif))
                            .padding(.horizontal, padding * 2)
                    }
                }
            )
        case let .carousel(i, c):
            return AnyView(
                VStack(alignment: .leading) {
                    CarouselView(items: i)
                        .frame(height: 300)
                    if let c = c {
                        Text(c)
                            .font(.system(.caption2, design: .serif))
                            .padding(.horizontal, padding * 2)
                    }
                }
            )
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(.mock)
    }
}

extension URL {
    static var hamilton: Self {
        .init(string: "https://images.unsplash.com/photo-1575425186775-b8de9a427e67?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&h=600&q=80")!
    }
    static var zanzibarBeachclub: Self {
        .init(string: "https://images.unsplash.com/photo-1516370873344-fb7c61054fa9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&h=600&q=80")!
    }
}
