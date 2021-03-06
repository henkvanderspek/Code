//
//  SceneViewController.swift
//  Nonokia
//
//  Created by Henk van der Spek on 20/05/2022.
//

import UIKit
import SceneKit
import SwiftUI
import AVKit

class SceneViewController: UIViewController {

    private lazy var sceneView: SCNView = {
        let view = SCNView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.scene = scene
        view.allowsCameraControl = true
//        view.showsStatistics = true
        view.defaultCameraController.interactionMode = .orbitTurntable
        view.defaultCameraController.minimumVerticalAngle = 0
        view.defaultCameraController.maximumVerticalAngle = 0.1
        view.autoenablesDefaultLighting = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        view.rendersContinuously = true
        return view
    }()
    
    private lazy var scene: SCNScene = {
        let s = SCNScene(named: "nokia.scn")!
        s.background.contents = UIColor.black
        s.rootNode.addChildNode(camera)
        return s
    }()
    
    private lazy var camera: SCNNode = {
        let camera = SCNCamera()
        let node = SCNNode()
        node.camera = camera
        node.position = .init(x: 0, y: 0, z: 6)
//        let c = SCNLookAtConstraint(target: ship)
//        c.isGimbalLockEnabled = true
//        node.constraints = [c]
        return node
    }()
    
    private lazy var testViewController: TestViewController = {
        let vc = TestViewController()
        vc.view.frame = .init(origin: .zero, size: .init(width: 250, height: 250))
        vc.willMove(toParent: self)
        addChild(vc)
        view.insertSubview(vc.view, at: 0)
        return vc
    }()
    
    private lazy var captureDevice: AVCaptureDevice? = {
        .default(.builtInWideAngleCamera, for: .video, position: .front)
    }()

    private lazy var layoutConstraints: [NSLayoutConstraint] = {
        return [
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
    }()
    
    private var didAddMaterial = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(sceneView)
        layoutConstraints.activate()
    }
}

private extension SceneViewController {
    @objc func tap(_ r: UIGestureRecognizer) {
        let p = r.location(in: sceneView)
        let r = sceneView.hitTest(p)
        guard let n = r.first?.node, n.name == "Cylinder" else { return }
        let s = scene.rootNode.childNode(withName: "Screen", recursively: true)!
        if didAddMaterial {
            testViewController.toggleShouldPresentPover()
        } else {
            Task {
                didAddMaterial = true
                s.geometry?.firstMaterial?.diffuse.contents = testViewController.view.layer
    //            s.geometry?.firstMaterial?.diffuse.contents = captureDevice
    //            let translation = SCNMatrix4MakeTranslation(-1, 0, 1)
    //            let rotation = SCNMatrix4MakeRotation(-Float.pi / 2, 0, 0, 1)
    //            let transform = SCNMatrix4Mult(translation, rotation)
    //            s.geometry?.firstMaterial?.diffuse.contentsTransform = transform
            }
        }
    }
}

extension CGSize {
    var sanitized: Self {
        let v = max(250, max(width, height))
        return .init(width: v, height: v)
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
