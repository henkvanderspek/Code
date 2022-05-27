//
//  AppStoring.swift
//  macOS
//
//  Created by Henk van der Spek on 27/05/2022.
//

import Foundation
import AppKit

protocol AppStoring {
    func store(_ a: Uicorn.App)
}

class LocalAppStorage: AppStoring {
    private lazy var pasteboard: NSPasteboard = {
        return .general
    }()
    private lazy var encoder: JSONEncoder = {
        return .init()
    }()
    func store(_ a: Uicorn.App) {
        do {
            let d = try encoder.encode(a)
            let s = String(data: d, encoding: .utf8)!
            print(s)
            pasteboard.clearContents()
            pasteboard.setString(s, forType: .string)
        } catch {
            print(error)
        }
    }
}

