//
//  NewspaperView.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import SwiftUI

struct NavigationBarSettings {
    let foregroundColor: Color
    let backgroundColor: Color
}

extension NavigationBarSettings {
    static var standard: Self {
        .init(foregroundColor: .white, backgroundColor: .black)
    }
}

private struct NavigationBarSettingsKey: EnvironmentKey {
    static let defaultValue: NavigationBarSettings = .standard
}

extension EnvironmentValues {
    var navigationBarSettings: NavigationBarSettings {
        get { self[NavigationBarSettingsKey.self] }
        set { self[NavigationBarSettingsKey.self] = newValue }
    }
}

struct NewspaperView: View {
    let newspaper: Newspaper
    private let padding = 16.0
    private let spacing = 24.0
    @State private var date = Date()
    @State private var isConceptVisible = false
    @Environment(\.navigationBarSettings.foregroundColor) private var foregroundColor
    @Environment(\.navigationBarSettings.backgroundColor) private var backgroundColor
    init(_ n: Newspaper) {
        newspaper = n
    #if os(iOS)
        let f = UIColor(foregroundColor)
        UINavigationBar.appearance().tintColor = f
        UINavigationBar.overrideAppearance(
            .custom(
                foregroundColor: f,
                backgroundColor: .init(backgroundColor)
            )
        )
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
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            isConceptVisible = true
                        } label: {
                            Image(systemName: "pencil")
                        }
                        .tint(foregroundColor)
                    }
                }
                .popover(isPresented: $isConceptVisible) {
                    ComposeArticleView()
                }
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
    static func custom(foregroundColor: UIColor, backgroundColor: UIColor) -> UINavigationBarAppearance {
        let a = UINavigationBarAppearance()
        let d: UIFontDescriptor.SystemDesign = .serif
        a.configureWithOpaqueBackground()
        a.backgroundColor = backgroundColor
        a.modifyTitleTextAttributes(foregroundColor, fontDesign: d)
        a.modifyLargeTitleTextAttributes(foregroundColor, fontDesign: d)
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
