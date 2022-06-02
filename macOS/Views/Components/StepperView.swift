//
//  StepperView.swift
//  Code
//
//  Created by Henk van der Spek on 18/05/2022.
//

import SwiftUI

extension Formatter {
    static var stepper: Formatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 1
        f.locale = .init(identifier: "US")
        return f
    }
}

struct StepperView<V: Comparable & Strideable & CustomStringConvertible>: View {
    @Binding var value: V?
    let `default`: V
    let range: ClosedRange<V>
    let step: V.Stride
    let header: String
    let showHeader: Bool
    @FocusState private var isTextFieldFocused: Bool
    private var formatter: Formatter
    init(_ v: Binding<V?>, default d: V, range r: ClosedRange<V>, step s: V.Stride, header h: String, formatter f: Formatter = .stepper, showHeader sh: Bool = true) {
        _value = v
        `default` = d
        range = r
        step = s
        header = h
        formatter = f
        showHeader = sh
    }
    var body: some View {
        VStack(alignment: .leading) {
            if showHeader {
                Header(header)
            }
            HStack(spacing: 0) {
                TextField(
                    "Value",
                    value: .init(
                        get: {
                            $value.wrappedValue ?? `default`
                        },
                        set: {
                            value = $0
                        }
                    ),
                    formatter: formatter
                )
                .textFieldStyle(.plain)
                .padding(.horizontal, 5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .focused($isTextFieldFocused)
                .overlay {
                    Color(nativeColor: .systemBackground)
                        .opacity(0.1)
                        .onTapGesture {
                            isTextFieldFocused = true
                        }
                }
//                Text(label(value ?? `default`))
//                    .frame(maxWidth: .infinity, alignment: .trailing)
                Stepper(header, value: Binding($value, default: `default`), in: range, step: step)
            }
            .frame(minWidth: 80)
            .background(.background)
            .cornerRadius(4)
            .labelsHidden()
        }
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(.constant(5), default: 1, range: 1...20, step: 1, header: "Count")
    }
}

protocol Formatible {
    init?<S>(_ text: S) where S: StringProtocol
    func formatted() -> String
}

extension Int: Formatible {
    init?<S>(_ text: S) where S : StringProtocol {
        guard let v = Int(String(text)) else { return nil }
        self = v
    }
}

extension Double: Formatible {
    func formatted() -> String {
        return formatted(.number.locale(.init(identifier: "US")).precision(.significantDigits(1)))
    }
}

extension Float: Formatible {
    func formatted() -> String {
        return formatted(.number.locale(.init(identifier: "US")).precision(.significantDigits(1)))
    }
}
