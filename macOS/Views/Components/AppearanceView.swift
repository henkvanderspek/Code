//
//  AppearanceView.swift
//  macOS
//
//  Created by Henk van der Spek on 25/05/2022.
//

import SwiftUI

struct AppearanceView<Content: View>: NSViewRepresentable {
    typealias CreateContent = () -> Content
    var colorScheme: ColorScheme?
    let createContent: CreateContent
    private var customAppearance: NSAppearance? {
        colorScheme.map { .init($0) } ?? nil
    }
    init(colorScheme cs: ColorScheme, createContent c: @escaping CreateContent) {
        colorScheme = cs
        createContent = c
    }
    func makeNSView(context: Context) -> NSAppearanceView<Content> {
        return .init(frame: .zero, content: createContent())
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
    init(frame f: NSRect = .zero, content: Content) {
        child = .init(rootView: content)
        super.init(frame: f)
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
