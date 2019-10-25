//
//  CameraViewController.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 24/10/19.
//

import UIKit
import AVFoundation

open class CameraViewController: TableViewController {
    override open var backgroundColor: UIColor { return UIColor.black }
    override open var tableViewBackgroundColor: UIColor { return UIColor.black }
    private var imageOutput: AVCaptureStillImageOutput = AVCaptureStillImageOutput()
    private var session: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    public weak var delegate: CameraViewControllerDelegate?

    override open func viewDidLoad() {
        super.viewDidLoad()
        initCamera()
        startCamera()
    }

    override open func stylingNavigation() {
        super.stylingNavigation()
        navigationController?.applyTransparentStyle()
        view.backgroundColor = backgroundColor
    }

    private func initCamera() {
        initImageOutput()
        initSession()
        initVideoPreviewLayer()
    }

    private func initImageOutput() {
        imageOutput = AVCaptureStillImageOutput()
        imageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
    }

    private func initSession() {
        guard let deviceInput = getDeviceInput() else { return }
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.photo
        session.addInput(deviceInput)
        if !session.canAddOutput(imageOutput) { return }
        session.addOutput(imageOutput)
        self.session = session
    }

    private func initVideoPreviewLayer() {
        guard let session = session else { return }
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        DispatchQueue.main.async {
            videoPreviewLayer.frame = self.view.bounds
            if videoPreviewLayer.superlayer == nil {
                self.view.layer.addSublayer(videoPreviewLayer)
            }
            self.videoPreviewLayer = videoPreviewLayer
        }
    }

    private func startCamera() {
        guard let session = session else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
        }
    }

    private func getDeviceInput() -> AVCaptureDeviceInput? {
        guard let primaryCamera = AVCaptureDevice.default(for: AVMediaType.video) else { return nil }
        var deviceInput: AVCaptureDeviceInput?
        do {
            deviceInput = try AVCaptureDeviceInput(device: primaryCamera)
        } catch _ as NSError {}
        return deviceInput
    }
}
