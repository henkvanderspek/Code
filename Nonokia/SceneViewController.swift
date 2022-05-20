//
//  SceneViewController.swift
//  Nonokia
//
//  Created by Henk van der Spek on 20/05/2022.
//

import UIKit
import SceneKit
import SwiftUI

class SceneViewController: UIViewController {

    private lazy var sceneView: SCNView = {
        let view = SCNView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.scene = scene
        return view
    }()
    
    private lazy var scene: SCNScene = {
        let s = SCNScene()
        s.background.contents = UIColor.black
        s.rootNode.addChildNode(ship)
        s.rootNode.addChildNode(camera)
        s.rootNode.addChildNode(sun)
        return s
    }()
    
    private lazy var screen: SCNNode = {
        .init(geometry: SCNPlane(width: 5, height: 5))
    }()
    
    private lazy var ship: SCNNode = {
        let n = SCNNode()
        n.addChildNode(screen)
        return n
    }()

    private lazy var sun: SCNNode = {
        let n = SCNNode()
        let light = SCNLight()
        light.type = .directional
        light.castsShadow = true
        light.orthographicScale = 10
        light.intensity = 1000
        light.temperature = 8000
        n.light = light
        //n.position = .init(x: 5, y: 2, z: 0)
        n.position = .init(x: 5, y: 2, z: 10)
        let c = SCNLookAtConstraint(target: ship)
        c.isGimbalLockEnabled = true
        n.constraints = [c]
        return n
    }()
    
    private lazy var camera: SCNNode = {
        let camera = SCNCamera()
        let node = SCNNode()
        node.camera = camera
        node.position = .init(x: 6, y: 8, z: 7)
//        node.position = .init(x: 0, y: 0, z: 10)
        let c = SCNLookAtConstraint(target: ship)
        c.isGimbalLockEnabled = true
        node.constraints = [c]
        return node
    }()
    
    private lazy var image: UIImage = {
        let w = view.bounds.size.width
        let h = view.bounds.size.height
        let c = UIHostingController(rootView: TestView().frame(width: w, height: h))
        let v = c.view!
        let s = v.intrinsicContentSize
        v.bounds = CGRect(origin: .zero, size: s)
        v.backgroundColor = .clear
        return UIGraphicsImageRenderer(size: s).image { _ in
            v.drawHierarchy(in: v.bounds, afterScreenUpdates: true)
        }
    }()

    private lazy var layoutConstraints: [NSLayoutConstraint] = {
        return [
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(sceneView)
        layoutConstraints.activate()
        Task {
            screen.geometry?.firstMaterial?.diffuse.contents = image
        }
    }
}

extension FloatingPoint {
    static func degrees(_ f: Self) -> Self {
        f * .pi / 180
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    subscript(offset: Int, defaultValue: Int = 0) -> Int {
        .init(String(self[offset])) ?? defaultValue
    }
}

extension SCNVector3 {
    init(_ x: Int, _ y: Int, _ z: Int) {
        self = .init(Double(x), Double(y), Double(z))
    }
}

struct TestView: View {
    var body: some View {
        VStack(spacing: 0) {
            Color.yellow
            Color.orange
            Color.pink
        }
    }
}
