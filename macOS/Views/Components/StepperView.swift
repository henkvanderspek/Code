//
//  StepperView.swift
//  Code
//
//  Created by Henk van der Spek on 18/05/2022.
//

import SwiftUI

struct StepperView<V: Comparable & Strideable & CustomStringConvertible & Formatible>: View {
    @Binding var value: V?
    let `default`: V
    let range: ClosedRange<V>
    let step: V.Stride
    let header: String
    let label: (V)->String
    init(_ v: Binding<V?>, default d: V, range r: ClosedRange<V>, step s: V.Stride, header h: String, label l: @escaping (V)->String = { "\($0.formatted())" }) {
        _value = v
        `default` = d
        range = r
        step = s
        header = h
        label = l
    }
    var body: some View {
        VStack(alignment: .leading) {
            Header(header)
            HStack(spacing: 5) {
                Text(label(value ?? `default`))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Stepper(header, value: Binding($value, default: `default`), in: range, step: step)
            }
            .frame(minWidth: 80)
            .background(.background)
            .cornerRadius(4)
        }
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(.constant(5), default: 1, range: 1...20, step: 1, header: "Count")
    }
}

protocol Formatible {
    func formatted() -> String
}

extension Int: Formatible {}
extension Double: Formatible {}
extension Float: Formatible {}
