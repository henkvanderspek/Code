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
    var model: Codable
    init(_ m: Binding<Uicorn.View.HStack>) {
        axis = .horizontal
        model = m.wrappedValue
    }
    init(_ m: Binding<Uicorn.View.VStack>) {
        axis = .vertical
        model = m.wrappedValue
    }
    init(_ m: Binding<Uicorn.View.ZStack>) {
        axis = .depth
        model = m.wrappedValue
    }
}

struct StackPropertiesView: View {
    @Binding var model: Stack
    init(_ m: Binding<Stack>) {
        _model = m
    }
    var body: some View {
        Section {
            Header("Axis")
            Picker("Axis", selection: $model.axis) {
                ForEach(Stack.Axis.allCases, id: \.self) {
                    Text($0.localizedString)
                }
            }
        }
        .labelsHidden()
    }
}

struct StackPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        StackPropertiesView(.constant(.init(.constant(Uicorn.View.ZStack([])))))
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
