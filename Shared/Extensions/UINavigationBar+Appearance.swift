//
//  UINavigationBar+Appearance.swift
//  iOS
//
//  Created by Henk van der Spek on 31/05/2022.
//

import UIKit

extension UINavigationBar {
    static func setupAppearance(_ c: NativeColor) {
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white
        ]
        let a = UINavigationBarAppearance()
        a.configureWithTransparentBackground()
        a.backgroundColor = c
        a.titleTextAttributes = attributes
        a.largeTitleTextAttributes = attributes
        appearance().standardAppearance = a
        appearance().compactAppearance = a
        appearance().scrollEdgeAppearance = a
    }
}
