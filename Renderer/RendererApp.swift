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
        ws.sizeRestrictions?.maximumSize = .init(width: 320, height: 800)
        window = UIWindow(windowScene: ws)
        let vc = HostController(rootView: RootView())
        window?.rootViewController = ViewController()
        window?.canResizeToFitContent = true
        window?.makeKeyAndVisible()
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let p = UInt32(35331)
        let remote = CARemoteLayerClient(serverPort: p)
        let layer = CALayer()
        layer.backgroundColor = UIColor.systemRed.cgColor
        layer.frame = view.bounds
        remote.layer = layer
        view.layer.addSublayer(layer)
        print(remote.clientId)
    }
}

class HostController<V: View>: UIHostingController<V> {
    override func viewDidLoad() {
        super.viewDidLoad()
//        let p = UInt32(34819)
//        let remote = CARemoteLayerClient(serverPort: p)
        let layer = CALayer()
        layer.backgroundColor = UIColor.systemRed.cgColor
        layer.frame = view.bounds
//        remote.layer = layer
        view.layer.addSublayer(layer)
//        print(remote.clientId)
    }
}

struct RootView: View {
    @StateObject private var backendController = Backend.Controller(configuration: .live)
    var body: some View {
        NavigationView {
            UicornView(.constant(.mock))
                .environmentObject(backendController)
        }
    }
}
