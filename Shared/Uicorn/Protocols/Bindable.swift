//
//  Bindable.swift
//  Code
//
//  Created by Henk van der Spek on 02/06/2022.
//

import SwiftUI

protocol Bindable {}

extension Bindable {
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
