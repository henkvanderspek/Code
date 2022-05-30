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
                                .image("heart.fill", fill: nil, action: .presentSelf),
                                .image("house.fill", fill: nil, action: .presentSelf),
                                .image("highlighter", fill: nil, action: .presentSelf),
                            ],
                            spacing: 5,
                            properties: .padding(.all(5))
                        ),
                        .hstack([
                                .image("gamecontroller.fill", fill: nil, action: .presentSelf),
                                .image("logo.playstation", fill: nil, action: .presentSelf),
                                .image("logo.xbox", fill: nil, action: .presentSelf),
                            ],
                            spacing: 5,
                            properties: .padding(.all(5))
                        ),
                        .hstack([
                                .image("airplane", fill: nil, action: .presentSelf),
                                .image("car.fill", fill: nil, action: .presentSelf),
                                .image("fuelpump.fill", fill: nil, action: .presentSelf),
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
