//
//  AppearanceView.swift
//  macOS
//
//  Created by Henk van der Spek on 25/05/2022.
//

import SwiftUI

struct AppearanceView<Content: View>: NSViewRepresentable {
    var colorScheme: ColorScheme?
    let content: Content
    private var customAppearance: NSAppearance? {
        colorScheme.map { .init($0) } ?? nil
    }
    init(colorScheme cs: ColorScheme, content c: Content) {
        colorScheme = cs
        content = c
    }
    func makeNSView(context: Context) -> NSAppearanceView<Content> {
        return .init(frame: .zero, customAppearance: customAppearance, content: content)
    }
    func updateNSView(_ nsView: NSAppearanceView<Content>, context: Context) {
        nsView.customAppearance = customAppearance
    }
}

class NSAppearanceView<Content: View>: NSView {
    private let child: NSHostingView<Content>
    var customAppearance: NSAppearance? {
        didSet {
            appearance = customAppearance
        }
    }
    init(frame f: NSRect = .zero, customAppearance a: NSAppearance?, content: Content) {
        child = .init(rootView: content)
        super.init(frame: f)
        customAppearance = a
        appearance = a
        addSubview(child)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layout() {
        super.layout()
        child.frame = bounds
    }
}

private extension NSAppearance {
    convenience init?(_ c: ColorScheme) {
        self.init(named: .init(c))
    }
}

private extension NSAppearance.Name {
    init(_ c: ColorScheme) {
        switch c {
        case .dark: self = .darkAqua
        case .light: fallthrough
        @unknown default: self = .aqua
        }
    }
}
