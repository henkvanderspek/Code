//
//  CodeView.swift
//  Code
//
//  Created by Henk van der Spek on 08/05/2022.
//

import SwiftUI

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
        valueProvider.provideValues(for: model)
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
