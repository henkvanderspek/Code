//
//  View+Instance.swift
//  Code
//
//  Created by Henk van der Spek on 30/05/2022.
//

import Foundation

extension Uicorn.View {
    class Instance: Codable {
        var componentId: String
        init(componentId cid: String) {
            componentId = cid
        }
    }
}

extension Uicorn.View.Instance: UicornViewType {}
