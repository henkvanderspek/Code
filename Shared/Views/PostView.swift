//
//  PostView.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import SwiftUI

struct PostView: View {
    let post: Article
    let padding: Double
    init(_ p: Article, padding pa: Double = 16.0) {
        post = p
        padding = pa
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            PostHeaderView(post.title, author: post.author, padding: padding)
            ForEach(post.items) {
                $0.view(padding: padding)
            }
        }
    }
}

private extension Article.Item {
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
                ImageView(url: u)
                    .frame(height: 400)
                    .caption(c, padding: padding * 2)
            )
        case let .location(co, c):
            return AnyView(
                LocationView(.init(title: "", coordinate: co))
                    .frame(height: 300)
                    .caption(c, padding: padding * 2)
            )
        case let .carousel(i, c):
            return AnyView(
                CarouselView(items: i)
                    .frame(height: 300)
                    .caption(c, padding: padding * 2)
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
    static var work: Self {
        .init(string: "https://images.unsplash.com/photo-1600880292203-757bb62b4baf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&h=600&q=80")!
    }
    static var karaoke: Self {
        .init(string: "https://images.unsplash.com/photo-1631746363761-e0f78d373b73?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&h=600&q=80")!
    }
    static var vaccination: Self {
        .init(string: "https://images.unsplash.com/photo-1612277795421-9bc7706a4a34?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80")!
    }
}
