//
//  Mock.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import Foundation

extension Uicorn.View {
    static var mock: Uicorn.View {
        .unsplash("pug")
    }
    static var post: Uicorn.View {
        .vstack([
                .hstack([
                        .image(id: .postAvatarId, modifiers: [.size(30), .cornerRadius(15)]),
                        .text(id: .postAuthorId)
                    ],
                    spacing: 15,
                    modifiers: [.padding(10)]
                ),
                .image(id: .postImageId, modifiers: [.height(240)]),
                .vstack([
                        .hstack([
                                .sfSymbol(.random(of: ["heart", "heart.fill"]), weight: .medium),
                                .sfSymbol("bubble.right", weight: .medium),
                                .sfSymbol("paperplane", weight: .medium),
                                .spacer,
                                .sfSymbol(.random(of: ["bookmark", "bookmark.fill"]), weight: .medium)
                            ],
                            spacing: 8
                        ),
                        .vstack([
                                .text(id: .postLikesId, font: .default.weight(.medium)),
                                .vstack([
                                        .text(id: .postCaptionId),
                                        .text(id: .postTagsId, foregroundColor: .system(.link)),
                                    ],
                                    alignment: .leading,
                                    spacing: 10
                                ),
                                .text(id: .postCommentsId, foregroundColor: .system(.gray))
                            ],
                            alignment: .leading,
                            spacing: 6
                        ),
                    ],
                    alignment: .leading,
                    spacing: 12,
                    modifiers: [.padding(10)]
                )
            ],
            alignment: .leading
        )
    }
    static var helloWorld: Uicorn.View {
        .zstack([
            .text("hello\nworld\n🌎", font: .init(type: .largeTitle, weight: .regular, design: .default, leading: .standard), alignment: .center, textCase: .uppercase),
            .rectangle
        ])
    }
    static var postInstances: Uicorn.View {
        .vscroll([
            .postInstance(
                values: [
                    .postAvatarId: .string("https://scontent-amt2-1.cdninstagram.com/v/t51.2885-19/169242891_784302095840018_9009495641411637305_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-amt2-1.cdninstagram.com&_nc_cat=102&_nc_ohc=khYShwcffFcAX80v25a&edm=ALQROFkBAAAA&ccb=7-5&oh=00_AT87LaSY5WTfNfFeTqwOp4p3eb1ihzprECM2DWgLyhCKsQ&oe=62ACFD09&_nc_sid=30a2ef"),
                    .postAuthorId: .string("Henk van der Spek"),
                    .postImageId: .string("https://scontent-amt2-1.cdninstagram.com/v/t51.2885-15/287221415_745392306660049_4525091539225969616_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-amt2-1.cdninstagram.com&_nc_cat=101&_nc_ohc=G6HfbTv-kxsAX8XuOCc&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=Mjg1OTUzNjQxMDcwMTAzNTUwMg%3D%3D.2-ccb7-5&oh=00_AT_yfFu9j0vsvOgIT_ptJ6cqLjpxGWwb436PLuONoKYI5Q&oe=62AD0931&_nc_sid=30a2ef"),
                    .postLikesId: .string("14.348 likes"),
                    .postCaptionId: .string("I've been drawing today.\nI really like this guy 🤓👍"),
                    .postTagsId: .string("#art #drawing #sketching"),
                    .postCommentsId: .string("View all 12 comments")
                ]
            ),
            .postInstance(
                values: [
                    .postAvatarId: .string("https://scontent-amt2-1.cdninstagram.com/v/t51.2885-19/169242891_784302095840018_9009495641411637305_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-amt2-1.cdninstagram.com&_nc_cat=102&_nc_ohc=khYShwcffFcAX80v25a&edm=ALQROFkBAAAA&ccb=7-5&oh=00_AT87LaSY5WTfNfFeTqwOp4p3eb1ihzprECM2DWgLyhCKsQ&oe=62ACFD09&_nc_sid=30a2ef"),
                    .postAuthorId: .string("Henk van der Spek"),
                    .postImageId: .string("https://scontent-amt2-1.cdninstagram.com/v/t51.2885-15/278644259_124029830235737_8474005044087012472_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-amt2-1.cdninstagram.com&_nc_cat=105&_nc_ohc=9PeJp2u8BqMAX8JqRSb&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=MjgyMTEwODYyMzk4ODY1MTAzOA%3D%3D.2-ccb7-5&oh=00_AT8z7s94O2SNc471yX1bUcdnHbdWl42YRRgb_BUiozL8yQ&oe=629D1E60&_nc_sid=30a2ef"),
                    .postLikesId: .string("233.769 likes"),
                    .postCaptionId: .string("Mister moody is in town 😡"),
                    .postTagsId: .string("#art #drawing #sketching"),
                    .postCommentsId: .string("View all 512 comments")
                ]
            ),
            .postInstance(
                values: [
                    .postAvatarId: .string("https://scontent-amt2-1.cdninstagram.com/v/t51.2885-19/169242891_784302095840018_9009495641411637305_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-amt2-1.cdninstagram.com&_nc_cat=102&_nc_ohc=khYShwcffFcAX80v25a&edm=ALQROFkBAAAA&ccb=7-5&oh=00_AT87LaSY5WTfNfFeTqwOp4p3eb1ihzprECM2DWgLyhCKsQ&oe=62ACFD09&_nc_sid=30a2ef"),
                    .postAuthorId: .string("Henk van der Spek"),
                    .postImageId: .string("https://scontent-frt3-1.cdninstagram.com/v/t51.2885-15/280730972_768930617850235_5686118124094263214_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-frt3-1.cdninstagram.com&_nc_cat=107&_nc_ohc=HWU62SYkauQAX_N7zH4&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=MjgzODY0Mjc0NTIxMjU0MTkwNA%3D%3D.2-ccb7-5&oh=00_AT9PTowsdNtWCcQVUvdL618h9F90qxOJ15cza8Uuy0V9Mg&oe=629DB929&_nc_sid=30a2ef"),
                    .postLikesId: .string("Liked by **banksy** and **others**"),
                    .postCaptionId: .string("Here's a throwback.\nOne of my earlier pencil drawings 👨🏻‍🎨👍"),
                    .postTagsId: .string("#art #drawing #sketching #nostalgia"),
                    .postCommentsId: .string("View all 47 comments")
                ]
            )
        ])
    }
}

extension Uicorn.Component {
    static var post: Uicorn.Component {
        .init(
            id: .postComponentId,
            title: "Post",
            view: .post,
            parameters: [
                .init(id: .unique, viewId: .postAvatarId, title: "Avatar URL", type: .string),
                .init(id: .unique, viewId: .postAuthorId, title: "Author", type: .string),
                .init(id: .unique, viewId: .postImageId, title: "Image URL", type: .string),
                .init(id: .unique, viewId: .postLikesId, title: "Likes", type: .string),
                .init(id: .unique, viewId: .postCaptionId, title: "Caption", type: .string),
                .init(id: .unique, viewId: .postTagsId, title: "Tags", type: .string),
                .init(id: .unique, viewId: .postCommentsId, title: "Comments", type: .string),
            ]
        )
    }
}

extension Uicorn.View.Instance {
    static var post: Uicorn.View.Instance {
        .init(
            id: .unique,
            componentId: .postComponentId,
            values: [
                .postAvatarId: .string("https://scontent-amt2-1.cdninstagram.com/v/t51.2885-19/169242891_784302095840018_9009495641411637305_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-amt2-1.cdninstagram.com&_nc_cat=102&_nc_ohc=mE72_8u5xgoAX9Hh5Jl&edm=ABfd0MgBAAAA&ccb=7-5&oh=00_AT_EEKk5ZCsJpRovOC40Sw34VCM-FTR_S4sg9d7hIjmWrQ&oe=629D2B09&_nc_sid=7bff83"),
                .postAuthorId: .string("Henk van der Spek"),
                .postImageId: .string("https://scontent-amt2-1.cdninstagram.com/v/t51.2885-15/280724483_1407259713081194_6125961954279869631_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-amt2-1.cdninstagram.com&_nc_cat=102&_nc_ohc=aWXBVklhFMwAX8SBuCT&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=MjgzODU4OTg0Mzc5ODMxOTcyOA%3D%3D.2-ccb7-5&oh=00_AT_TIu90VjFk4DaAYygJfG4dCXQMaI2wKKwjq2YnRa0l2A&oe=629C20BF&_nc_sid=30a2ef"),
                .postLikesId: .string("14.348 likes"),
                .postCaptionId: .string("I've been drawing today.\nI really like this guy 🤓👍"),
                .postTagsId: .string("#art #drawing #sketching"),
                .postCommentsId: .string("View all 12 comments")
            ]
        )
    }
}
