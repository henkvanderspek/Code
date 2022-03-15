//
//  NewspaperView.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import SwiftUI


struct NewspaperView: View {
    let newspaper: Newspaper
    private let padding = 16.0
    private let spacing = 24.0
    init(_ n: Newspaper) {
        newspaper = n
        UINavigationBar.overrideAppearance(.custom)
    }
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: .init(repeating: .init(), count: 1), alignment: .leading, spacing: spacing) {
                    ForEach(Array(newspaper.posts.enumerated()), id: \.offset) { i, e in
                        VStack(spacing: spacing) {
                            if i != 0 {
                                Color
                                    .teal
                                    .frame(height: 2)
                                    .padding(.leading, padding)
                            }
                            PostView(e, padding: padding)
                        }
                    }
                }
                .padding(.vertical, padding)
                .navigationTitle("My Gazette")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct NewspaperView_Previews: PreviewProvider {
    static var previews: some View {
        NewspaperView(.mock)
    }
}

extension UINavigationBarAppearance {
    static var custom: UINavigationBarAppearance {
        let a = UINavigationBarAppearance()
        let f = a.titleTextAttributes[.font] as! UIFont
        let d = f.fontDescriptor
        let s = d.withDesign(.serif)!
        let f2 = UIFont(descriptor: s, size: 0.0)
        a.configureWithOpaqueBackground()
        a.backgroundColor = .black
        a.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: f2
        ]
        return a
    }
}

extension UINavigationBar {
    static func overrideAppearance(_ a: UINavigationBarAppearance) {
        appearance().standardAppearance = a
        appearance().scrollEdgeAppearance = a
    }
}
