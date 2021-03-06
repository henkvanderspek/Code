//
//  App.swift
//  Code
//
//  Created by Henk van der Spek on 09/05/2022.
//

import Foundation

extension Uicorn {
    class Base {
        var isSelected: Bool = false
    }
    class App: Base, Codable {
        let id: String
        var title: String
        var color: Color
        var screens: [Screen]
        var components: [Component]
        init(id i: String, title t: String, color clr: Color, screens s: [Screen], components c: [Component]) {
            id = i
            title = t
            color = clr
            screens = s
            components = c
        }
    }
}

extension Uicorn.App {
    static var mock: Uicorn.App {
        .mock(.default)
    }
    static func mock(_ m: Uicorn.Screen.Mock) -> Uicorn.App {
        .init(
            id: .unique,
            title: "Social",
            color: .system(.yellow),
            screens: [.mock(m)],
            components: [
                .post
            ]
        )
    }
}


extension String {
    static let postComponentId: Self = "__postComponentId"
    static let postAvatarId: Self = "__postAvatarId"
    static let postImageId: Self = "__postImageId"
    static let postLikesId: Self = "__postLikesId"
    static let postCommentsId: Self = "__postCommentsId"
    static let postAuthorId: Self = "__postAuthorId"
    static let postCaptionId: Self = "__postCaptionId"
    static let postTagsId: Self = "__postTagsId"
}
