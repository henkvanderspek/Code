//
//  StepperView.swift
//  Code
//
//  Created by Henk van der Spek on 18/05/2022.
//

import SwiftUI

struct StepperView<V: Comparable & Strideable & CustomStringConvertible>: View {
    @Binding var value: V?
    let `default`: V
    let range: ClosedRange<V>
    let header: String
    let label: (V)->String
    init(_ v: Binding<V?>, default d: V, range r: ClosedRange<V>, header h: String, label l: @escaping (V)->String = { "\($0)" }) {
        _value = v
        `default` = d
        range = r
        header = h
        label = l
    }
    var body: some View {
        Header(header)
        HStack(spacing: 5) {
            Text(label(value ?? `default`))
                .frame(maxWidth: .infinity, alignment: .trailing)
            Stepper(header, value: Binding($value, default: `default`), in: range)
        }
        .frame(width: 80)
        .background(.background)
        .cornerRadius(4)
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(.constant(5), default: 1, range: 1...20, header: "Count")
    }
}
