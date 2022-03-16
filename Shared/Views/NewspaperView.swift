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
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack {
                            Spacer()
                            if let dateRange = newspaper.dateRange {
                                DatePicker(
                                    "",
                                    selection: $date,
                                    in: dateRange,
                                    displayedComponents: [.date]
                                )
                                .labelsHidden()
                                .background(.white)
                                .id(calendarId)
                                .onChange(of: date) { _ in
                                    calendarId += 1 // This forces a reload and closes the picker
                                }
                                .clipped()
                                .cornerRadius(5)
                                .shadow(radius: 5)
                            } else {
                                IssueDateView(issue.date)
                                    .cornerRadius(5)
                            }
                        }
                        .padding()
                        .accentColor(.teal)
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
        a.configureWithOpaqueBackground()
        a.backgroundColor = .black
        a.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: (a.titleTextAttributes[.font] as! UIFont).withDesign(.serif)
        ]
        a.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: (a.largeTitleTextAttributes[.font] as! UIFont).withDesign(.serif)
        ]
        return a
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
