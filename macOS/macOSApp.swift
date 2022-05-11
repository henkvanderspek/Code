//
//  macOSApp.swift
//  macOS
//
//  Created by Henk van der Spek on 28/02/2022.
//

import Cocoa
import SwiftUI

@main
struct macOSApp: App {
    @StateObject private var backendController = Backend.Controller(configuration: .live)
    var body: some Scene {
        WindowGroup {
            AppView(.mock)
                .environmentObject(backendController)
//            HostView()
        }
    }
}

struct HostView: NSViewRepresentable {
    class V: NSView {
        private lazy var server: CARemoteLayerServer = {
            return .shared()
        }()
        func startServer() {
            print(server.serverPort)
        }
        func addRemoteClient() {
            var id: UInt32 = 0
            let remote = CALayer(remoteClientId: id)
            remote.frame = layer!.bounds
            print(remote)
            layer!.addSublayer(remote)
        }
        override func mouseDown(with event: NSEvent) {
            super.mouseDown(with: event)
            addRemoteClient()
        }
    }
    func makeNSView(context: Context) -> V {
        let v = V()
        v.startServer()
        v.layer = CALayer()
        v.layer?.backgroundColor = NSColor.systemCyan.cgColor
        v.wantsLayer = true
        v.layerUsesCoreImageFilters = true
        return v
    }
    func updateNSView(_ nsView: V, context: Context) {
    }
}
