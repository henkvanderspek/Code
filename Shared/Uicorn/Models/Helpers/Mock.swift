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
                        .image("https://scontent-amt2-1.cdninstagram.com/v/t51.2885-19/169242891_784302095840018_9009495641411637305_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-amt2-1.cdninstagram.com&_nc_cat=102&_nc_ohc=mE72_8u5xgoAX9Hh5Jl&edm=ABfd0MgBAAAA&ccb=7-5&oh=00_AT_EEKk5ZCsJpRovOC40Sw34VCM-FTR_S4sg9d7hIjmWrQ&oe=629D2B09&_nc_sid=7bff83", id: .postAvatarId, properties: .size(30).cornerRadius(15)),
                        .text("Henk van der Spek")
                    ],
                    spacing: 15,
                    properties: .padding(10)
                ),
                .image("https://scontent-amt2-1.cdninstagram.com/v/t51.2885-15/280724483_1407259713081194_6125961954279869631_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-amt2-1.cdninstagram.com&_nc_cat=102&_nc_ohc=aWXBVklhFMwAX8SBuCT&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=MjgzODU4OTg0Mzc5ODMxOTcyOA%3D%3D.2-ccb7-5&oh=00_AT_TIu90VjFk4DaAYygJfG4dCXQMaI2wKKwjq2YnRa0l2A&oe=629C20BF&_nc_sid=30a2ef", id: .postImageId, properties: .height(240)),
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
                                .text("14.348 likes", font: .default.weight(.medium)),
                                .vstack([
                                        .text("I've been drawing today.\nI really like this guy 🤓👍"),
                                        .text("#art #drawing #sketching", foregroundColor: .system(.link)),
                                    ],
                                    spacing: 10
                                ),
                                .text("View all 12 comments", foregroundColor: .system(.gray))
                            ],
                            alignment: .leading,
                            spacing: 6
                        ),
                    ],
                    alignment: .leading,
                    spacing: 12,
                    properties: .padding(10)
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
                    .postAvatarId: .string("https://media-exp1.licdn.com/dms/image/C4D03AQGA46DC7a3uWg/profile-displayphoto-shrink_200_200/0/1516891077583?e=1659571200&v=beta&t=hYYl1N9g3fgRpxAzpE_Y9uYd23Bm02CuOYneW_njJjQ")
                ]
            ),
            .postInstance(values: [:]),
            .postInstance(values: [:])
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
                .init(id: .unique, viewId: .postImageId, title: "Image URL", type: .string)
            ]
        )
    }
}
