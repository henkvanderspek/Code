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
    @State private var date = Date()
    @State private var calendarId: Int = 0
    init(_ n: Newspaper) {
        newspaper = n
    #if os(iOS)
        UINavigationBar.overrideAppearance(.custom)
    #endif
    }
    var body: some View {
        NavigationView {
            if let issue = newspaper.issue(from: date) {
                ZStack {
                    ScrollView {
                        IssueView(issue, spacing: spacing, padding: padding)
                            .padding(.vertical, padding)
                    }
                }
                .navigationTitle("My Gazette")
            }
        }.onAppear {
            date = newspaper.latestIssue?.date ?? date
        }
    }
}

struct NewspaperView_Previews: PreviewProvider {
    static var previews: some View {
        NewspaperView(.mock)
    }
}

#if os(iOS)
extension UINavigationBarAppearance {
    static var custom: UINavigationBarAppearance {
        let a = UINavigationBarAppearance()
        let c: UIColor = .white
        let d: UIFontDescriptor.SystemDesign = .serif
        a.configureWithOpaqueBackground()
        a.backgroundColor = .black
        a.modifyTitleTextAttributes(c, fontDesign: d)
        a.modifyLargeTitleTextAttributes(c, fontDesign: d)
        return a
    }
}

private extension UINavigationBarAppearance {
    func modifyTitleTextAttributes(_ f: UIColor, fontDesign: UIFontDescriptor.SystemDesign) {
        titleTextAttributes = titleTextAttributes.withForegroundColor(f, fontDesign: fontDesign)
    }
    func modifyLargeTitleTextAttributes(_ f: UIColor, fontDesign: UIFontDescriptor.SystemDesign) {
        largeTitleTextAttributes = largeTitleTextAttributes.withForegroundColor(f, fontDesign: fontDesign)
    }
}

private extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    func withForegroundColor(_ f: UIColor, fontDesign: UIFontDescriptor.SystemDesign) -> Self {
        var ret = self
        ret[.foregroundColor] = f
        ret[.font] = (ret[.font] as? UIFont)?.withDesign(.serif)
        return ret
    }
}

extension UIFont {
    func withDesign(_ d: UIFontDescriptor.SystemDesign) -> Self {
        .init(
            descriptor: fontDescriptor.withDesign(d)!,
            size: 0.0
        )
    }
}

extension UINavigationBar {
    static func overrideAppearance(_ a: UINavigationBarAppearance) {
        appearance().standardAppearance = a
        appearance().scrollEdgeAppearance = a
    }
}
#endif
