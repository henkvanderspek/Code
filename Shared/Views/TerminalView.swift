//
//  TermView.swift
//  iOS
//
//  Created by Henk van der Spek on 25/04/2022.
//

import AppKit
import SwiftUI
import WebKit

struct TerminalView: View {
    struct V: NSViewRepresentable {
        typealias Create = (()->WKWebView)
        private let create: Create
        init(create c: @escaping @autoclosure Create) {
            create = c
        }
        func makeNSView(context: Context) -> WKWebView {
            return create()
        }
        func updateNSView(_ webView: WKWebView, context: Context) {
            webView.loadHTMLString(.html, baseURL: nil)
        }
    }
    private let process = Process()
    private let standardInput = Pipe()
    private let standardOutput = Pipe()
    private let standardError = Pipe()
    private let webView = WKWebView()
    init() {
        process.launchPath = "/bin/sh"
        process.arguments = ["-i"]
        process.standardInput = standardInput
        process.standardOutput = standardOutput
        process.standardError = standardError
        standardOutput.fileHandleForReading.readabilityHandler = readOutput
//        standardError.fileHandleForReading.readabilityHandler = {
//            print("Error: \(String(data: $0.availableData, encoding: .utf8) ?? "?")")
//        }
        process.terminationHandler = {
            print($0)
        }
    }
    var body: some View {
        V(create: webView).onAppear {
            self.process.launch()
            guard let d = String("pwd\n").data(using: .utf8) else { return }
            do {
                try self.standardInput.fileHandleForWriting.write(contentsOf: d)
            } catch {
                print(error)
            }
        }
    }
    private func readOutput(_ file: FileHandle) {
        let s = String(data: file.availableData, encoding: .utf8) ?? "No output"
        print(s)
        DispatchQueue.main.async {
            writeOutput(s)
        }
    }
    private func writeOutput(_ s: String) {
        if (!webView.isLoading) {
            webView.evaluateJavaScript("write('foo');") { result, error in
                print(result ?? "No result")
                print(error ?? "No error")
            }
        } else {
            print("Web view is loading")
            print(s)
        }
    }
}

private extension String {
    static var html: String {
        return """
            <!doctype html>
            <html>
                <head>
                    <script>
                        let term;
                        function write(s) {
                            if (!term) return;
                            term.write(s);
                        }
                    </script>
                    <style>
                        body { padding: 0; margin: 0; }
                    </style>
                    <link rel="stylesheet" href="https://unpkg.com/xterm/css/xterm.css" />
                    <script src="https://unpkg.com/xterm/lib/xterm.js"></script>
                </head>
                <body>
                    <div id="terminal"></div>
                    <script>
                        term = new Terminal();
                        term.open(document.getElementById('terminal'));
                    </script>
                </body>
            </html>
        """
    }
}
