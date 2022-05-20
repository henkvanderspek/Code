//
//  CameraView.swift
//  Code
//
//  Created by Henk van der Spek on 20/03/2022.
//

import UIKit
import AVKit

class CameraView: UIView {

    private lazy var videoDataOutput: AVCaptureVideoDataOutput = {
        let v = AVCaptureVideoDataOutput()
        v.alwaysDiscardsLateVideoFrames = true
        v.connection(with: .video)?.isEnabled = true
        v.setSampleBufferDelegate(self, queue: .main)
        return v
    }()

    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let l = AVCaptureVideoPreviewLayer(session: session)
        l.videoGravity = .resizeAspectFill
        return l
    }()

    private lazy var captureDevice: AVCaptureDevice? = {
        AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position)
    }()
    
    private lazy var session: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = .vga640x480
        return s
    }()
    
    private let position: AVCaptureDevice.Position
    private var image: CIImage?
    
    private lazy var context = {
        CIContext()
    }()

    init(frame: CGRect = .zero, position p: AVCaptureDevice.Position) {
        position = p
        super.init(frame: frame)
        layer.masksToBounds = true
        layer.addSublayer(previewLayer)
        DispatchQueue.main.async(execute: beginSession)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func beginSession() {
        guard let d = captureDevice, let i = try? AVCaptureDeviceInput(device: d) else { return }
        session.addInput(i)
        session.addOutput(videoDataOutput)
        session.startRunning()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer.frame = bounds
    }

    var capturedDevice: AVCaptureDevice? {
        return captureDevice
    }
}

extension CameraView: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        connection.videoOrientation = .portraitUpsideDown
        image = CIImage(cvPixelBuffer: pixelBuffer)
    }
}
