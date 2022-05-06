//
//  ArticleView.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    let padding: Double
    init(_ p: Article, padding pa: Double = 16.0) {
        article = p
        padding = pa
    }
    var body: some View {
        let last = max(0, article.items.count - 1)
        VStack(alignment: .leading) {
            ArticleHeaderView(article, padding: padding)
            ForEach(Array(article.items.enumerated()), id: \.offset) { index, item in
                let s = item.spacing(isLast: index == last)
                item
                    .view(padding: padding)
                    .padding(.top, s.top)
                    .padding(.bottom, s.bottom)
            }
        }
    }
}

private extension Article.Item {
    struct Spacing {
        let top: Double
        let bottom: Double
    }
    func spacing(isLast: Bool) -> Spacing {
        let v: Double = {
            switch type {
            case let .text(t):
                switch t.type {
                case .body: return 20.0
                case .callout: return 16.0
                case .subhead: return 13.0
                case .footnote: return 10.0
                case .caption: return 8.0
                case .caption2: return 4.0
                }
            case .carousel, .location, .image:
                return 20.0
            }
        }()
        return .init(top: v, bottom: isLast ? 0 : v)
    }
    func view(padding: Double) -> AnyView {
        switch type {
        case let .text(t):
            return AnyView(
                Text(t.value)
                    .font(.system(.init(from: t.type), design: .serif))
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

private extension Font.TextStyle {
    init(from other: Article.Text.`Type`) {
        switch other {
        case .body: self = .body
        case .callout: self = .callout
        case .subhead: self = .subheadline
        case .footnote: self = .footnote
        case .caption: self = .caption
        case .caption2: self = .caption2
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(.mock)
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
