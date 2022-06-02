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
            .modifiers(Binding($model.modifiers), scaleFactor: scaleFactor)
            .overlay {
                Rectangle()
                    .strokeBorder(.orange, lineWidth: 2.0)
                    .isHidden(!$model.wrappedValue.isSelected)
                    .clipped()
                    //.blendMode(.lighten)
            }
//            // TODO: Use the approach in below link to show consistent iOS style popovers
//            // TODO: https://pspdfkit.com/blog/2022/presenting-popovers-on-iphone-with-swiftui/
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

private extension View {
    func onSafeTapGesture(action: Uicorn.View.Action?, perform p: @escaping (Uicorn.View.Action) -> Void) -> some View {
        guard let a = action else { return AnyView(self) }
        return AnyView(onTapGesture {
            p(a)
        })
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
        case let .color(c):
            Color(c.binding)
        case .spacer:
            Spacer()
        case .empty:
            EmptyView()
        }
    }
}
