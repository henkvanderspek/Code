//
//  UicornView.swift
//  Uicorn
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

enum ResolveContext {
    case `default`
    case sheet
}

typealias Resolve = (String, ResolveContext) -> String

protocol UicornHost {
    func resolve(_ s: String, context: ResolveContext) -> String
}

extension UicornHost {
    func resolve(_ s: String, context: ResolveContext) -> String {
        return s
    }
    func resolve(_ s: String) -> String {
        return resolve(s, context: .default)
    }
}

struct UicornView: View {
    @Binding var model: Uicorn.View
    private let resolver: Resolve?
    @State private var sheetView: AnyView?
    @State private var shouldShowSheet = false
    init(_ v: Binding<Uicorn.View>, resolver r: Resolve? = nil) {
        _model = v
        resolver = r
    }
    var body: some View {
        content
            .padding(.leading, .init(model.properties?.padding.leading ?? 0))
            .padding(.trailing, .init(model.properties?.padding.trailing ?? 0))
            .padding(.top, .init(model.properties?.padding.top ?? 0))
            .padding(.bottom, .init(model.properties?.padding.bottom ?? 0))
            .background {
                if let v = backgroundView() {
                    v
                }
            }
            .cornerRadius(.init(model.properties?.cornerRadius ?? 0))
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // TODO: Use the approach in below link to show consistent iOS style popovers
            // TODO: https://pspdfkit.com/blog/2022/presenting-popovers-on-iphone-with-swiftui/
            .popover(isPresented: $shouldShowSheet) {
                sheetView?
                    .frame(minWidth: 300, minHeight: 300)
            }
            .onSafeTapGesture(action: model.action) {
                switch $0.actionType {
                case .presentSelf:
                    sheetView = AnyView(content)
                    shouldShowSheet = true
                }
            }
    }
}

private extension View {
    func onSafeTapGesture(action: Uicorn.View.Action?, perform p: @escaping (Uicorn.View.Action) -> Void) -> some View {
        guard let a = action else { return AnyView(self) }
        return AnyView(onTapGesture {
            p(a)
        })
    }
}

private extension UicornView {
    @ViewBuilder func backgroundView() -> (some View)? {
        model.properties?.backgroundColor.map { Color($0) }
    }
}

extension UicornView: UicornHost {
    func resolve(_ s: String, context c: ResolveContext) -> String {
        resolver?(s, shouldShowSheet ? .sheet : .`default`) ?? s
    }
}

struct MockHost: UicornHost {}

private extension UicornView {
    @ViewBuilder var content: some View {
        switch $model.wrappedValue.type {
        case let .hstack(v):
            HStack(v.binding, host: self)
        case let .vstack(v):
            VStack(v.binding, host: self)
        case let .zstack(v):
            ZStack(v.binding, host: self)
        case let .text(t):
            Text(t.binding, host: self)
        case let .image(i):
            Image(i.binding, host: self)
        case let .collection(c):
            Collection(c.binding, host: self)
        case let .shape(s):
            Shape(s.binding, host: self)
        case .spacer:
            Spacer()
        case .empty:
            EmptyView()
        }
    }
}

extension UicornViewType {
    var binding: Binding<Self> {
        binding {
            print($0)
        }
    }
    func binding(set: @escaping (Self)->()) -> Binding<Self> {
        .init(
            get: {
                self
            },
            set: set
        )
    }
}

extension Color {
    init(_ c: Uicorn.Color.Custom) {
        self = .white // TODO:
    }
}

extension Uicorn.Color.Custom {
    init(_ c: Color) {
        self = .init(red: 255, green: 255, blue: 255, alpha: 1.0) // TODO:
    }
}

extension Color {
    init(_ c: Uicorn.Color) {
        switch c.colorType {
        case let .system(s):
            self = .init(s)
        case let .custom(c):
            self = .init(c)
        }
    }
    init(_ s: Uicorn.Color.System) {
        switch s {
        case .primary: self = .primary
        case .secondary: self = .secondary
        case .yellow: self = .yellow
        case .blue: self = .blue
        case .red: self = .red
        case .orange: self = .orange
        case .green: self = .green
        case .mint: self = .mint
        case .teal: self = .teal
        case .cyan: self = .cyan
        case .indigo: self = .indigo
        case .purple: self = .purple
        case .pink: self = .pink
        case .brown: self = .brown
        case .gray: self = .gray
        case .gray2: self = .init(nativeColor: .systemGray2)
        case .gray3: self = .init(nativeColor: .systemGray3)
        case .gray4: self = .init(nativeColor: .systemGray4)
        case .gray5: self = .init(nativeColor: .systemGray5)
        case .gray6: self = .init(nativeColor: .systemGray6)
        case .label: self = .init(nativeColor: .label)
        case .secondaryLabel: self = .init(nativeColor: .secondaryLabel)
        case .quaternaryLabel: self = .init(nativeColor: .quaternaryLabel)
        case .placeholderText: self = .init(nativeColor: .placeholderText)
        case .separator: self = .init(nativeColor: .separator)
        case .opaqueSeparator: self = .init(nativeColor: .opaqueSeparator)
        case .link: self = .init(nativeColor: .link)
        case .background: self = .init(nativeColor: .systemBackground)
        }
    }
}

extension Font {
    init(_ f: Uicorn.Font) {
        self = .system(.init(f.type), design: .init(f.design)).weight(.init(f.weight))
    }
}

extension Font.TextStyle {
    init(_ t: Uicorn.Font.`Type`) {
        switch t {
        case .body: self = .body
        case .callout: self = .callout
        case .caption: self = .caption
        case .caption2: self = .caption2
        case .footnote: self = .footnote
        case .headline: self = .headline
        case .subheadline: self = .subheadline
        case .largeTitle: self = .largeTitle
        case .title: self = .title
        case .title2: self = .title2
        case .title3: self = .title3
        }
    }
}

extension Font.Weight {
    init(_ w: Uicorn.Font.Weight) {
        switch w {
        case .regular: self = .regular
        case .ultraLight: self = .ultraLight
        case .thin: self = .thin
        case .light: self = .light
        case .medium: self = .medium
        case .semibold: self = .semibold
        case .bold: self = .bold
        case .heavy: self = .heavy
        case .black: self = .black
        }
    }
}

extension Font.Design {
    init(_ d: Uicorn.Font.Design) {
        switch d {
        case .default: self = .default
        case .monospaced: self = .monospaced
        case .rounded: self = .rounded
        case .serif: self = .serif
        }
    }
}

extension VerticalAlignment {
    init(_ a: Uicorn.VerticalAlignment) {
        switch a {
        case .top: self = .top
        case .center: self = .center
        case .bottom: self = .bottom
        case .firstTextBaseline: self = .firstTextBaseline
        case .lastTextBaseline: self = .lastTextBaseline
        }
    }
}

extension HorizontalAlignment {
    init(_ a: Uicorn.HorizontalAlignment) {
        switch a {
        case .leading: self = .leading
        case .center: self = .center
        case .trailing: self = .trailing
        }
    }
}

extension Alignment {
    init(_ a: Uicorn.Alignment) {
        switch a {
        case .topLeading: self = .topLeading
        case .top: self = .top
        case .topTrailing: self = .topTrailing
        case .leading: self = .leading
        case .center: self = .center
        case .trailing: self = .trailing
        case .bottomLeading: self = .bottomLeading
        case .bottom: self = .bottom
        case .bottomTrailing: self = .bottomTrailing
        }
    }
}

extension TextAlignment {
    init(_ a: Uicorn.TextAlignment) {
        switch a {
        case .leading: self = .leading
        case .center: self = .center
        case .trailing: self = .trailing
        }
    }
}

extension Text.Case {
    init?(_ a: Uicorn.TextCase) {
        switch a {
        case .standard: return nil
        case .uppercase: self = .uppercase
        case .lowercase: self = .lowercase
        }
    }
}
