//
//  ComponentController.swift
//  Code
//
//  Created by Henk van der Spek on 01/06/2022.
//

import SwiftUI

class ComponentController: ObservableObject {
    var app: Binding<Uicorn.App>? = nil
    func instance(from id: String) -> Binding<Uicorn.View>? {
        guard let $a = component(from: id) else { return nil }
        return $a.view
    }
    func component(from id: String) -> Binding<Uicorn.Component>? {
        guard let $a = app?.components.first(where: { $0.wrappedValue.id == id }) else { return nil }
        return $a
    }
    var components: [Uicorn.Component]? {
        return app?.components.wrappedValue
    }
}
