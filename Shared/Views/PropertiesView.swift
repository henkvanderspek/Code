//
//  PropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 06/05/2022.
//

import SwiftUI
import Combine

class Properties: ObservableObject {
    struct Item: Identifiable {
        let id: String
        let title: String?
        var type: ConfigurationType
        init(id: String = .unique, title: String? = nil, type: ConfigurationType) {
            self.id = id
            self.title = title
            self.type = type
        }
    }
    @Published var items: [Item]
    @Published var references: [Reference] = []
    init(_ items: [Item] = []) {
        self.items = items
    }
    func setItems(_ i: [Item], references r: [Reference], willChange handler: @escaping ([Item])->()) -> AnyCancellable? {
        items = i
        references = r
        return i.isEmpty ? nil : objectWillChange.sink { [weak self] in
            DispatchQueue.main.async {
                self.map { handler($0.items) }
            }
        }
    }
}

struct PropertiesView: SwiftUI.View {
    @Binding var app: JsonUI.App
    @Binding var selectedItem: TreeView.Item
    private let style: ConfigurationStyle = .default
    //@EnvironmentObject var properties: Properties
    var body: some SwiftUI.View {
//        List($properties.items) { $item in
//            content(for: $item)
//                .listRowInsets(.init(top: 8, leading: 0, bottom: 0, trailing: 0))
//        }
//        .listStyle(.sidebar)
        if let v = app.recursiveView(withId: selectedItem.id) {
            Text(v.shortName)
        } else {
            Text("No screen selected")
        }
    }
}
                                   
extension JsonUI.App {
    func recursiveView(withId: String) -> JsonUI.View? {
        return nil
    }
}

extension Properties.Item {
    static var spacer: Self {
        .init(type: .spacer)
    }
}

private extension PropertiesView {
    @ViewBuilder private func content(for item: Binding<Properties.Item>) -> some SwiftUI.View {
        switch item.wrappedValue.type {
        case .property:
            Text("Property")
            // TODO: Move to dedicated view "ProperyView"
//            HStack {
//                if let t = item.wrappedValue.title {
//                    Text(t)
//                        .lineLimit(1)
//                        .frame(width: style.labelWidth, alignment: .leading)
//                }
//                switch p.type {
//                case .text:
//                    TextFieldView(text: item.propertyText)
//                case .rectangle:
//                    RectangleView(configuration: item.propertyRectangleConfiguration)
//                }
//            }
        case .color:
            Text("Color")
//            ColorPicker(selection: item.color.value, supportsOpacity: true) {
//                Text(item.wrappedValue.title ?? "Color")
//                    .lineLimit(1)
//                    .frame(width: style.labelWidth, alignment: .leading)
//            }
//            .frame(height: 25.0)
        case .image:
            Text("Image")
//            ImageSettingsView(configuration: item.imageConfiguration)
//                .frame(height: 25.0)
        case .sfSymbol:
            Text("Image")
//            SfSymbolView(configuration: item.sfSymbolViewConfiguration)
        case .camera:
            Text("Camera")
//            CameraSettingsView(configuration: item.cameraConfiguration)
        case .tapAction:
            Text("Tap Action")
//            EventActionView(
//                configuration: item.eventActionConfiguration,
//                references: inspector.references
//            )
        case .text:
            Text("Text")
//            TextSettingsView(
//                configuration: item.textConfiguration
//            )
        case .margins:
            Text("Margins")
//            RectangleView(
//                configuration: item.marginsConfiguration
//            )
        case .font:
            Text("Margins")
//            FontView(
//                configuration: item.fontConfiguration
//            )
        case .alignment:
            Text("Alignment")
//            TextAlignmentView(
//                configuration: item.textAlignmentConfiguration
//            )
        case .stack:
            Text("Stack")
//            StackSettingsView(
//                configuration: item.stackConfiguration
//            )
        case .spacer:
            Text("Spacer")
        case .coordinate:
            Text("Coordinate")
//            CoordinateView(
//                configuration: item.coordinateConfiguration
//            )
        case .size:
            Text("Size")
//            SizeView(
//                configuration: item.sizeConfiguration
//            )
        }
    }
}

private extension Properties.Item {
    var propertyText: String {
        get {
            guard case let .property(p) = type, case .text = p.type else { fatalError() }
            return p.value
        }
        set {
            guard case let .property(p) = type, case .text = p.type else { fatalError() }
            type = .property(.init(name: p.name, value: newValue, type: .text))
        }
    }
//    var propertyRectangleConfiguration: RectangleView.Configuration {
//        get {
//            guard case let .property(p) = type, case .rectangle = p.type else { fatalError() }
//            let r: ConfigurationType.Rect = {
//                if let d = p.value.data(using: .utf8) {
//                    return try? JSONDecoder().decode(ConfigurationType.Rect.self, from: d)
//                } else {
//                    return nil
//                }
//            }() ?? .zero
//            return .init(label: "", rect: r)
//        }
//        set {
//            guard
//                case let .property(p) = type,
//                case .rectangle = p.type,
//                let d = try? JSONEncoder().encode(newValue.rect),
//                let s = String(data: d, encoding: .utf8)
//            else {
//                fatalError()
//            }
//            type = .property(.init(name: p.name, value: s, type: .rectangle))
//        }
//    }
    var color: ConfigurationType.Color {
        get {
            guard case let .color(c) = type else { fatalError() }
            return c
        }
        set {
            type = .color(newValue)
        }
    }
//    var imageConfiguration: ImageSettingsView.Configuration {
//        get {
//            guard case let .image(v) = type else { fatalError() }
//            switch v {
//            case let .constant(s):
//                return .init(text: s, isVariable: false)
//            case let .variable(s):
//                return .init(text: s, isVariable: true)
//            }
//        }
//        set {
//            type = .image(.init(from: newValue))
//        }
//    }
//    var sfSymbolViewConfiguration: SfSymbolView.Configuration {
//        get {
//            guard case let .sfSymbol(v, c) = type else { fatalError() }
//            switch v {
//            case let .constant(s):
//                return .init(text: s, isVariable: false, tintColor: c)
//            case let .variable(s):
//                return .init(text: s, isVariable: true, tintColor: c)
//            }
//        }
//        set {
//            type = .sfSymbol(.init(from: newValue), newValue.tintColor)
//        }
//    }
    var cameraConfiguration: ConfigurationType.Position {
        get {
            guard case let .camera(c) = type else { fatalError() }
            return c
        }
        set {
            type = .camera(newValue)
        }
    }
    var eventActionConfiguration: ConfigurationType.EventAction {
        get {
            guard case let .tapAction(a) = type else { fatalError() }
            return a
        }
        set {
            type = .tapAction(newValue)
        }
    }
//    var textConfiguration: TextSettingsView.Configuration {
//        get {
//            guard case let .text(s) = type else { fatalError() }
//            return .init(title: "Text", text: s)
//        }
//        set {
//            type = .text(newValue.text)
//        }
//    }
//    var marginsConfiguration: RectangleView.Configuration {
//        get {
//            guard case let .margins(m) = type else { fatalError() }
//            return .init(label: "Margins", rect: .init(from: m))
//        }
//        set {
//            type = .margins(.init(from: newValue.rect))
//        }
//    }
//    var fontConfiguration: FontView.Configuration {
//        get {
//            guard case let .font(f) = type else { fatalError() }
//            return .init(weight: f.weight, textStyle: f.textStyle)
//        }
//        set {
//            type = .font(.init(weight: newValue.weight, textStyle: newValue.textStyle))
//        }
//    }
//    var textAlignmentConfiguration: TextAlignmentView.Configuration {
//        get {
//            guard case let .textAlignment(t) = type else { fatalError() }
//            return .init(title: "Alignment", textAlignment: t)
//        }
//        set {
//            type = .textAlignment(newValue.textAlignment)
//        }
//    }
//    var stackConfiguration: StackSettingsView.Configuration {
//        get {
//            guard case let .stack(s) = type else { fatalError() }
//            return s
//        }
//        set {
//            type = .stack(newValue)
//        }
//    }
//    var coordinateConfiguration: CoordinateView.Configuration {
//        get {
//            guard case let .coordinate(c) = type else { fatalError() }
//            return .init(title: "Coordinate", coordinate: c)
//        }
//        set {
//            type = .coordinate(newValue.coordinate)
//        }
//    }
//    var sizeConfiguration: SizeView.Configuration {
//        get {
//            guard case let .size(s) = type else { fatalError() }
//            return .init(size: s)
//        }
//        set {
//            type = .size(newValue.size)
//        }
//    }
}

extension ConfigurationType.Color {
    init(fromSwiftUIColor c: Color) {
        value = c
    }
    init(fromAppColor c: JsonUI.View.Attributes.Color) {
        value = .init(c.value)
    }
}

extension JsonUI.View.Attributes.Alignment: CaseIterable {
    static var allCases: [Self] = [
    ]
    var localizedTitle: String {
        switch self {
        }
    }
}

//extension ConfigurationType.Position: CaseIterable {
//    var localizedTitle: String {
//        switch self {
//        case .front: return "Front"
//        case .back: return "Back"
//        }
//    }
//}
//
//extension ConfigurationType.Event: CaseIterable {
//    var localizedTitle: String {
//        switch self {
//        case .none: return "None"
//        case .tap: return "Tap"
//        }
//    }
//}
//
//extension ConfigurationType.Action: CaseIterable {
//    var localizedTitle: String {
//        switch self {
//        case .none: return "None"
//        case .alert: return "Alert"
//        case .dismiss: return "Dismiss"
//        case .present: return "Present"
//        case .push: return "Push"
//        case .open: return "Open"
//        }
//    }
//}
//
//extension ConfigurationType.Rect: Codable {}

extension ConfigurationType.Rect {
    init(from padding: JsonUI.View.Attributes.Padding) {
        leading = padding.leading ?? 0
        trailing = padding.trailing ?? 0
        top = padding.top ?? 0
        bottom = padding.bottom ?? 0
    }
    static var zero: Self {
        .init(leading: 0, trailing: 0, top: 0, bottom: 0)
    }
}

extension JsonUI.View.Attributes.Padding {
    init(from rect: ConfigurationType.Rect) {
        leading = rect.leading
        trailing = rect.trailing
        top = rect.top
        bottom = rect.bottom
    }
}

extension Font.Weight: CaseIterable {
    public static var allCases: [Self] {
        return [
            .ultraLight,
            .thin,
            .light,
            .regular,
            .medium,
            .semibold,
            .bold,
            .heavy,
            .black
        ]
    }
    var localizedString: String {
        switch self {
        case .ultraLight: return "Ultra Light"
        case .thin: return "Thin"
        case .light: return "Light"
        case .medium: return "Medium"
        case .semibold: return "Semibold"
        case .bold: return "Bold"
        case .heavy: return "Heavy"
        case .black: return "Black"
        case .regular: fallthrough
        default: return "Regular"
        }
    }
}

extension Font.TextStyle {
    var localizedString: String {
        switch self {
        case .callout: return "Callout"
        case .caption: return "Caption"
        case .caption2: return "Caption 2"
        case .footnote: return "Caption 3"
        case .headline: return "Headline"
        case .subheadline: return "Subheadline"
        case .largeTitle: return "Large title"
        case .title: return "Title"
        case .title2: return "Title 2"
        case .title3: return "Title 3"
        case .body: fallthrough
        @unknown default: return "Body"
        }
    }
}

//private extension ConfigurationType.Value {
//    init(from other: SfSymbolView.Configuration) {
//        self = other.isVariable ? .variable(other.text) : .constant(other.text)
//    }
//}
//
//private extension ConfigurationType.Value {
//    init(from other: ImageSettingsView.Configuration) {
//        self = other.isVariable ? .variable(other.text) : .constant(other.text)
//    }
//}

//struct InspectorView_Previews: PreviewProvider {
//    private static let data: [Inspector.Item] = [
////        .init(title: "Search", type: .text("Foo")),
//        .init(title: "Fill", type: .color(.init(fromSwiftUIColor: .red))),
//        .init(title: "Background", type: .color(.init(fromSwiftUIColor: .yellow))),
//        .init(type: .image(.variable("pug"))),
//        .init(type: .tapAction(.default))
//    ]
//    static var previews: some SwiftUI.View {
//        InspectorView()
//            .environmentObject(Inspector(data))
//            .previewLayout(.fixed(width: 300, height: 600))
//    }
//}

extension ConfigurationType.EventAction {
    static var `default`: Self {
        return .init(event: .none, action: .none, referenceId: nil)
    }
}

struct PropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesView(app: .constant(.mock), selectedItem: .constant(.mock))
    }
}
