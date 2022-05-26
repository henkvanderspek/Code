//
//  Mock.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import Foundation

extension Uicorn.View {
    static var mock: Uicorn.View {
        //.unsplash("pug")
        .vstack([
            .hstack([
                .zstack([
                    .helloWorld,
                    .rectangle(.system(.yellow))
                ], action: .presentSelf),
                .zstack([
                    .capsule(.system(.pink)),
                    .rectangle(.system(.mint))
                ])
            ]),
            .hstack([
                .rectangle(.system(.blue)),
                .zstack([
                    .vstack([
                        .hstack([
                                .image("heart.fill", type: .system, action: .presentSelf),
                                .image("house.fill", type: .system, action: .presentSelf),
                                .image("highlighter", type: .system, action: .presentSelf),
                            ],
                            spacing: 5,
                            properties: .padding(.all(5))
                        ),
                        .hstack([
                                .image("gamecontroller.fill", type: .system, action: .presentSelf),
                                .image("logo.playstation", type: .system, action: .presentSelf),
                                .image("logo.xbox", type: .system, action: .presentSelf),
                            ],
                            spacing: 5,
                            properties: .padding(.all(5))
                        ),
                        .hstack([
                                .image("airplane", type: .system, action: .presentSelf),
                                .image("car.fill", type: .system, action: .presentSelf),
                                .image("fuelpump.fill", type: .system, action: .presentSelf),
                            ],
                            spacing: 5,
                            properties: .padding(.all(5))
                        ),
                    ]),
                    .rectangle(.system(.yellow)),
                ])
            ]),
            .hstack([
                .randomRemoteImage(action: .presentSelf),
                .rectangle(.system(.teal))
            ]),
            .hstack([
                .rectangle(.system(.cyan)),
                .unsplash("candy")
            ]),
        ])
    }
}
