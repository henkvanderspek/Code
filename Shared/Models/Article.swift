//
//  Post.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import Foundation

struct Article {
    struct Text {
        enum `Type` {
            case body
            case callout
            case caption
            case caption2
        }
        let type: `Type`
        let value: String
    }
    struct Item {
        enum `Type` {
            case text(Text)
            case image(url: URL, caption: String?)
            case location(coordinate: Coordinate, caption: String?)
            case carousel(items: [CarouselItem], caption: String?)
        }
        let id = UUID()
        let type: `Type`
    }
    let id = UUID()
    let title: String
    let published: Date
    let author: String
    let items: [Item]
}

extension Article: Identifiable {}
extension Article.Item: Identifiable {}

extension Article.Text {
    static func body(_ s: String) -> Self {
        .init(type: .body, value: s)
    }
    static func callout(_ s: String) -> Self {
        .init(type: .callout, value: s)
    }
    static func caption(_ s: String) -> Self {
        .init(type: .caption, value: s)
    }
    static func caption2(_ s: String) -> Self {
        .init(type: .caption2, value: s)
    }
}

extension Article.Item {
    static func text(_ t: Article.Text) -> Self {
        .init(type: .text(t))
    }
    static func image(_ u: URL, caption: String? = nil) -> Self {
        .init(type: .image(url: u, caption: caption))
    }
    static func location(_ c: Coordinate, caption: String? = nil) -> Self {
        .init(type: .location(coordinate: c, caption: caption))
    }
    static func carousel(_ i: [CarouselItem], caption: String? = nil) -> Self {
        .init(type: .carousel(items: i, caption: caption))
    }
}

extension Article {
    static var mock: Self {
        mock(date: .now)
    }
    static func mock(date: Date) -> Self {
        [mock2(date: date), mock3(date: date), mock4(date: date), mock5(date: date)].randomElement()!
    }
    static func mock2(date: Date) -> Self {
        .init(
            title: "Family BBQ 😍",
            published: date,
            author: "Kelly Williams",
            items: [
                .text(.body("Today is finally the day for the family BBQ. I've been organizing it with my sister, and it's going to be great. The weather forecast is excellent and no cancellations so far!")),
                .image(.hamilton, caption: "Hamilton is looking forward to the meat 🍖"),
                .text(.body("We reserved a spot at our favorite beach bar. The only thing we have to bring is ourselves, the kids and pets of course. I'm going to keep you guys updated on this live blog.")),
                .text(.callout("This is where we are going. Look us up if you're there!")),
                .carousel([
                    .location(.zanzibarBeachclub),
                    .image(.zanzibarBeachclub)
                ], caption: "Zanzibar Beachclub, Den Haag")
            ]
        )
    }
    static func mock3(date: Date) -> Self {
        .init(
            title: "Promotion 🤩",
            published: date,
            author: "Shaun Wilder",
            items: [
                .text(.body("I finally got the good news today: I made promotion to Executive Manager. This is such great news, since I've been at the firm for almost a decade now.")),
                .image(.work, caption: "Happy faces in my team also 🙌"),
            ]
        )
    }
    static func mock4(date: Date) -> Self {
        .init(
            title: "Karaoke Night 🥳",
            published: date,
            author: "Bruce Sap",
            items: [
                .text(.body("Our team lead told us we could organise more events. We seem to have budget for it. After asking around we decided to organise a karaoke night, since the last time it was a lot of fun.")),
                .image(.karaoke, caption: "Lisa blew us away the last time 🎤"),
            ]
        )
    }
    static func mock5(date: Date) -> Self {
        .init(
            title: "Positive Test 🤕",
            published: date,
            author: "Nick Mullens",
            items: [
                .text(.body("I wasn't feeling myself last couple of days. Last night I got a fever even. So, I decided to get tested, since I don't want to bring this to the office tomorrow. Low and behold I tested positive. That's going to be quarantine for me the next two weeks.")),
                .image(.vaccination, caption: "This was my during my vaccination 💉"),
            ]
        )
    }
}
