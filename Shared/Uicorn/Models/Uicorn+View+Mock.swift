//
//  Uicorn+View+Mock.swift
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
                    .vstack([
                        .spacer,
                        .hstack([
                            .text("H", font: .init(.largeTitle, weight: .black)),
                            .text("E", font: .init(.largeTitle, weight: .black)),
                            .text("L", font: .init(.largeTitle, weight: .black)),
                            .text("L", font: .init(.largeTitle, weight: .black)),
                            .text("O", font: .init(.largeTitle, weight: .black)),
                        ]),
                        .hstack([
                            .text("W", font: .init(.largeTitle, weight: .black)),
                            .text("O", font: .init(.largeTitle, weight: .black)),
                            .text("R", font: .init(.largeTitle, weight: .black)),
                            .text("L", font: .init(.largeTitle, weight: .black)),
                            .text("D", font: .init(.largeTitle, weight: .black)),
                        ]),
                        .text("🌎", font: .init(.largeTitle, weight: .black)),
                        .spacer
                    ]),
                    .rectangle(.system(.yellow))
                ], action: .presentSelf),
                .zstack([
                    .capsule(.system(.pink)),
                    .rectangle(.system(.mint))
                ])
            ]),
            .hstack([
                .rectangle(.system(.blue)),
                .vstack([
                    .hstack([
                        .zstack([
                            .image("heart.fill", type: .system),
                            .rectangle(.system(.yellow))
                        ]),
                        .zstack([
                            .image("house.fill", type: .system),
                            .rectangle(.system(.yellow))
                        ]),
                        .zstack([
                            .image("highlighter", type: .system),
                            .rectangle(.system(.yellow))
                        ])
                    ]),
                    .hstack([
                        .zstack([
                            .ellipse(.system(.primary)),
                            .rectangle(.system(.yellow))
                        ]),
                        .zstack([
                            .ellipse(.system(.primary)),
                            .rectangle(.system(.yellow))
                        ]),
                        .zstack([
                            .ellipse(.system(.primary)),
                            .rectangle(.system(.yellow))
                        ])
                    ]),
                    .hstack([
                        .zstack([
                            .ellipse(.system(.primary)),
                            .rectangle(.system(.yellow))
                        ]),
                        .zstack([
                            .ellipse(.system(.primary)),
                            .rectangle(.system(.yellow))
                        ]),
                        .zstack([
                            .ellipse(.system(.primary)),
                            .rectangle(.system(.yellow))
                        ])
                    ]),
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
