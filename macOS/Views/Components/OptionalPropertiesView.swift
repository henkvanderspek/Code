//
//  OptionalPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 26/05/2022.
//

import SwiftUI

struct OptionalPropertiesView<T, V: View>: View {
    let header: String
    @Binding var value: T?
    var defaultValue: T
    var content: (Binding<T>)->V
    var body: some View {
        Section {
            createHeader()
            if let v = Binding($value) {
                VStack {
                    content(v)
                }
                .padding(.top, 5)
            }
        }
        .labelsHidden()
    }
}

extension OptionalPropertiesView {
    @ViewBuilder func createHeader() -> some View {
        let add = $value.wrappedValue == nil
        let action = add ? "Add" : "Delete"
        let icon = add ? "plus" : "trash"
        HStack {
            Header(header).opacity(add ? 0.5 : 1.0)
            Spacer()
            Button {
                $value.wrappedValue = add ? defaultValue : nil
            } label: {
                Label("\(action) \(header)", systemImage: icon)
                    .labelStyle(.iconOnly)
                    .frame(width: 10)
            }
            .buttonStyle(.borderless)
            .opacity(add ? 1.0 : 0.5)
        }
    }
}

struct OptionalPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        OptionalPropertiesView(header: "Foo", value: .constant(nil), defaultValue: "Blaat") {
            Text($0.wrappedValue)
        }
    }
}
