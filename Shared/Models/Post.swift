//
//  Post.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import Foundation

struct Post {
    struct Item {
        enum `Type` {
            case paragraph(String)
            case image(url: URL, caption: String?)
            case location(coordinate: Coordinate, caption: String?)
            case carousel(items: [CarouselItem], caption: String?)
        }
        let id = UUID()
        let type: `Type`
    }
    let id = UUID()
    let title: String
    let date: Date
    let items: [Item]
}

extension Post: Identifiable {}
extension Post.Item: Identifiable {}

extension Post.Item {
    static func paragraph(_ s: String) -> Self {
        .init(type: .paragraph(s))
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

extension Post {
    static var mock: Self {
        .init(
            title: "Family BBQ 😍",
            date: .init(),
            items: [
                .paragraph("Today is finally the day for the family BBQ. I've been organising it with my sister and it's going to be great. The weather forcast is excellent and no cancellations so far!"),
                .image(.hamilton, caption: "Hamilton is looking forward to the meat 🍖"),
                .paragraph("We reserved a spot at our favorite beach bar. The only thing we have to bring is ourselves, the kids and pets of course. I'm going to keep you guys updated on this live blog."),
                .paragraph("This is where we are going. Look us up if you're there!"),
                .carousel([
                    .location(.zanzibarBeachclub),
                    .image(.zanzibarBeachclub)
                ], caption: "Zanzibar Beachclub, Den Haag")
            ]
        )
    }
}
