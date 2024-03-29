//
//  RendererApp.swift
//  Renderer
//
//  Created by Henk van der Spek on 11/05/2022.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
}


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let ws = (scene as? UIWindowScene) else { return }
        let size = CGSize(width: 320, height: 568)
        ws.sizeRestrictions?.minimumSize = size
        ws.sizeRestrictions?.maximumSize = size
        window = UIWindow(windowScene: ws)
        let vc = UIHostingController(rootView: RootView())
//        let vc = ViewController()
        window?.rootViewController = vc
        window?.canResizeToFitContent = true
        window?.makeKeyAndVisible()
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.connect)))
    }
    @objc func connect() {
        let p = UInt32(ProcessInfo.processInfo.arguments.last!)!
        let remote = CARemoteLayerClient(serverPort: p)
        let layer = CALayer()
        layer.backgroundColor = UIColor.systemOrange.cgColor
        layer.frame = view.bounds
        remote.layer = layer
        print(remote.clientId, terminator: "")
        fflush(stdout)
    }
}

class HostController<V: View>: UIHostingController<V> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct RootView: View {
    @StateObject private var backendController = BackendController(configuration: .live)
    var body: some View {
        UicornView(.constant(.mock))
            .environmentObject(backendController)
    }
}
