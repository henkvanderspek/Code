//
//  Mock.swift
//  Uicorn
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
                    .text("HELLO\nWORLD\n🌎", font: .init(.largeTitle, weight: .black)),
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
                                .image("heart.fill", type: .system),
                                .image("house.fill", type: .system),
                                .image("highlighter", type: .system),
                            ],
                            spacing: 5,
                            padding: .all(5)
                        ),
                        .hstack([
                                .image("gamecontroller.fill", type: .system),
                                .image("logo.playstation", type: .system),
                                .image("logo.xbox", type: .system),
                            ],
                            spacing: 5,
                            padding: .all(5)
                        ),
                        .hstack([
                                .image("airplane", type: .system),
                                .image("car.fill", type: .system),
                                .image("fuelpump.fill", type: .system),
                            ],
                            spacing: 5,
                            padding: .all(5)
                        ),
                    ]),
                    .rectangle(.system(.yellow)),
                ])
            ]),
            .hstack([
                .image(.random, type: .remote, action: .presentSelf),
                .rectangle(.system(.teal))
            ]),
            .hstack([
                .rectangle(.system(.cyan)),
                .unsplash("candy")
            ]),
        ])
    }
}

private extension String {
    static var allImages: [Self] {
        return [
            "https://images.unsplash.com/photo-1575425186775-b8de9a427e67?auto=format&fit=crop&w=687&q=80",
            "https://images.unsplash.com/photo-1523626797181-8c5ae80d40c2?auto=format&fit=crop&w=500&q=60",
            "https://images.unsplash.com/photo-1517849845537-4d257902454a?auto=format&fit=crop&w=500&q=60",
            "https://images.unsplash.com/photo-1541364983171-a8ba01e95cfc?auto=format&fit=crop&w=500&q=60",
            "https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?auto=format&fit=crop&w=500&q=60",
            "https://images.unsplash.com/photo-1523626752472-b55a628f1acc?auto=format&fit=crop&w=500&q=60"
        ]
    }
    static var random: Self {
        return allImages.randomElement()!
    }
}
