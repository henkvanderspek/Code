//
//  StackPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 25/05/2022.
//

import SwiftUI

class Stack {
    enum Axis: String, CaseIterable {
        case horizontal
        case vertical
        case depth
    }
    var axis: Axis
    init(_ a: Axis) {
        axis = a
    }
}

struct StackPropertiesView: View {
    @Binding var model: Stack
    private var content: AnyView
    init(_ m: Binding<Stack>, _ v: Binding<Uicorn.View.HStack>) {
        _model = m
        content = AnyView(HStackPropertiesView(v))
    }
    init(_ m: Binding<Stack>, _ v: Binding<Uicorn.View.VStack>) {
        _model = m
        content = AnyView(VStackPropertiesView(v))
    }
    init(_ m: Binding<Stack>, _ v: Binding<Uicorn.View.ZStack>) {
        _model = m
        content = AnyView(ZStackPropertiesView(v))
    }
    var body: some View {
        Section {
            Header("Axis")
            Picker("Axis", selection: $model.axis) {
                ForEach(Stack.Axis.allCases, id: \.self) {
                    Text($0.localizedString)
                }
            }
            content
        }
        .labelsHidden()
    }
}

struct StackPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        StackPropertiesView(.constant(.init(.horizontal)), .constant(Uicorn.View.HStack([], alignment: .center, spacing: 0)))
    }
}

private extension Stack.Axis {
    var localizedString: String {
        switch self {
        case .horizontal: return "Horizontal"
        case .vertical: return "Vertical"
        case .depth: return "Depth"
        }
    }
}
