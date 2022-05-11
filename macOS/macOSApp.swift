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
//            AppView(.mock)
//                .environmentObject(backendController)
            HostView()
                .id(UUID())
        }
    }
}

struct HostView: NSViewRepresentable {
    class V: NSView {
        private lazy var server: CARemoteLayerServer = {
            return .shared()
        }()
        private lazy var process: Process = {
            let p = Process()
            p.executableURL = URL(fileURLWithPath: "/Users/henk/Library/Developer/Xcode/DerivedData/Code-ddslrnogiwjjfqfkfvetshuirxld/Build/Products/Debug-maccatalyst/Renderer.app/Contents/MacOS/Renderer")
            return p
        }()
        private lazy var output: Pipe = {
            return .init()
        }()
        private var isLaunched: Bool = false
        func addRemoteClient() {
            print(server.serverPort)
            process.arguments = [String(server.serverPort)]
            process.standardOutput = output
            output.fileHandleForReading.readabilityHandler = { handle in
                let d = handle.availableData
                guard !d.isEmpty else { return }
                let s = String(data: d, encoding: .utf8)!
                let cid = UInt32(s)!
                Task {
                    self.update(from: cid)
                }
            }
            process.launch()
        }
        override func mouseDown(with event: NSEvent) {
            super.mouseDown(with: event)
            guard !isLaunched else { return }
            isLaunched = true
            addRemoteClient()
        }
        @MainActor
        private func update(from id: UInt32) {
            print("Remote ClientId: \(id)")
            let remote = CALayer(remoteClientId: id)
            remote.frame = layer!.frame
            remote.position = .init(x: layer!.frame.midX, y: layer!.frame.midY)
            layer!.addSublayer(remote)
        }
    }
    func makeNSView(context: Context) -> V {
        let v = V()
        v.layer = CALayer()
        v.layer?.backgroundColor = NSColor.systemCyan.cgColor
        v.wantsLayer = true
        v.layerUsesCoreImageFilters = true
        return v
    }
    func updateNSView(_ nsView: V, context: Context) {
    }
}
