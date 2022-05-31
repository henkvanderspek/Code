//
//  CodeView.swift
//  Code
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

class ScreenSettings: ObservableObject {
    @Published var size: CGSize
    init(size s: CGSize) {
        size = s
    }
}

class ComponentController: ObservableObject {
    var app: Binding<Uicorn.App>? = nil
    func instance(from id: String) -> Binding<Uicorn.View>? {
        guard let $a = app?.components.first(where: { $0.wrappedValue.id == id }) else { return nil }
        return $a.view
    }
    func component(from id: String) -> Binding<Uicorn.Component>? {
        guard let $a = app?.components.first(where: { $0.wrappedValue.id == id }) else { return nil }
        return $a
    }
    var components: [Uicorn.Component]? {
        return app?.components.wrappedValue
    }
}

typealias EmptyValueProvider = ValueProvider

class ValueProvider: ObservableObject {
    let instance: Uicorn.View.Instance?
    init(instance i: Uicorn.View.Instance? = nil) {
        instance = i
    }
    func provideValues(for v: Binding<Uicorn.View>) {
        if let val = instance?.values[v.id] {
            switch v.wrappedValue.type {
            case let .image(i):
                v.wrappedValue.type = .image(val.string.map { i.string($0) } ?? i)
            default: ()
            }
        } else {
            print("Ignore request for values")
        }
    }
}

extension Uicorn.View.Image {
    func string(_ v: String) -> Self {
        var i = self
        switch type {
        case .remote:
            i.type = .remote(value: .init(v))
        case let .system(s):
            i.type = .system(value: .init(name: v, fill: s.fill, type: s.type, weight: s.weight, scale: s.scale))
        }
        return i
    }
}

struct UicornView: View {
    @EnvironmentObject private var screenSettings: ScreenSettings
    @EnvironmentObject private var valueProvider: ValueProvider
    @Binding var model: Uicorn.View
    @State private var sheetView: AnyView?
    @State private var shouldShowSheet = false
    @ScaledMetric private var scaleFactor = 1.0
    init(_ v: Binding<Uicorn.View>) {
        _model = v
    }
    var body: some View {
        content
            .frame(model.properties?.frame ?? .default, scaleFactor: scaleFactor)
            .cornerRadius(cornerRadius)
            .padding(.init(model.properties?.padding ?? .zero, scaleFactor: scaleFactor))
            .background {
                backgroundView()
                    .cornerRadius(cornerRadius)
            }
            .opacity(.init(model.properties?.opacity ?? 1.0))
            .overlay {
                Rectangle()
                    .strokeBorder(.orange, lineWidth: 2.0)
                    .isHidden(!model.isSelected)
                    .clipped()
            }
            // TODO: Use the approach in below link to show consistent iOS style popovers
            // TODO: https://pspdfkit.com/blog/2022/presenting-popovers-on-iphone-with-swiftui/
            .popover(isPresented: $shouldShowSheet) {
                sheetView?
                    .frame(minWidth: 300, minHeight: 300)
            }
            .onSafeTapGesture(action: model.action) {
                switch $0.type {
                case .presentSelf:
                    sheetView = AnyView(content)
                    shouldShowSheet = true
                }
            }
    }
}

extension UicornView {
    var cornerRadius: Double {
        .init(model.properties?.cornerRadius ?? 0).multiplied(by: scaleFactor)
    }
}

private extension View {
    func onSafeTapGesture(action: Uicorn.View.Action?, perform p: @escaping (Uicorn.View.Action) -> Void) -> some View {
        guard let a = action else { return AnyView(self) }
        return AnyView(onTapGesture {
            p(a)
        })
    }
    func frame(_ f: Uicorn.Frame, scaleFactor s: CGFloat) -> some View {
        frame(width: f.w?.multiplied(by: s), height: f.h?.multiplied(by: s), alignment: f.a)
    }
}

private extension EdgeInsets {
    static var zero: Self {
        .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
    init(_ p: Uicorn.Padding, scaleFactor: CGFloat) {
        self.init(
            top: .init(p.top).multiplied(by: scaleFactor),
            leading: .init(p.leading).multiplied(by: scaleFactor),
            bottom: .init(p.bottom).multiplied(by: scaleFactor),
            trailing: .init(p.trailing).multiplied(by: scaleFactor)
        )
    }
}

private extension FloatingPoint {
    func multiplied(by f: Self) -> Self {
        self * f
    }
}

private extension Uicorn.Frame {
    var w: CGFloat? {
        let v = width.map { CGFloat($0) }
        return v ?? 0 > 0 ? v : nil
    }
    var h: CGFloat? {
        let v = height.map { CGFloat($0) }
        return v ?? 0 > 0 ? v : nil
    }
    var a: Alignment {
        .init(alignment)
    }
}

private extension UicornView {
    @ViewBuilder func backgroundView() -> some View {
        model.properties?.backgroundColor.map { AnyView(Color($0)) } ?? AnyView(EmptyView())
    }
}

private extension UicornView {
    private var sanitizedModel: Uicorn.View {
        valueProvider.provideValues(for: $model)
        return $model.wrappedValue
    }
    @ViewBuilder var content: some View {
        switch sanitizedModel.type {
        case let .hstack(v):
            HStack(v.binding)
        case let .vstack(v):
            VStack(v.binding)
        case let .zstack(v):
            ZStack(v.binding)
        case let .text(t):
            Text(t.binding)
        case let .image(i):
            Image(i.binding)
        case let .collection(c):
            Collection(c.binding)
        case let .shape(s):
            Shape(s.binding)
        case let .map(m):
            Map(m.binding)
        case let .scroll(s):
            Scroll(s.binding)
        case let .instance(i):
            Instance(i.binding)
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
        switch c.type {
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
        self = .system(.init(f.type), design: .init(f.design))
            .weight(.init(f.weight))
            .leading(.init(f.leading))
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

extension Axis.Set {
    init(_ a: Uicorn.Axis) {
        switch a {
        case .horizontal: self = .horizontal
        case .vertical: self = .vertical
        }
    }
}

extension Image.Scale {
    init(_ a: Uicorn.ImageScale) {
        switch a {
        case .small: self = .small
        case .medium: self = .medium
        case .large: self = .large
        }
    }
}

extension Font.Leading {
    init(_ d: Uicorn.Font.Leading) {
        switch d {
        case .standard: self = .standard
        case .loose: self = .loose
        case .tight: self = .tight
        }
    }
}
