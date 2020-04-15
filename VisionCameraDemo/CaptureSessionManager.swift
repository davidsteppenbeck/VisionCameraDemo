//
//  CaptureSessionManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/13.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

/// A `CaptureSessionManager` is reponsible for setting up and managing the flow of an `AVCaptureSession` instance.
final class CaptureSessionManager: NSObject {

    // MARK:- Properties

    weak var delegate: CaptureSessionManagerDelegate?

    private let authorizationManager = AuthorizationManager()

    /// Keeps a strong reference to the sample buffer for snapshots.
    private (set) var sampleBuffer: CMSampleBuffer?

    /// Keeps track of the snapshot state: `false` when the video feed is running, otherwise `true`.
    private (set) var didSnapPhoto: Bool = false {
        didSet {
            if !didSnapPhoto {
                sampleBuffer = nil
            }

            startVideoSession()
        }
    }

    /// The layer that displays the video as it’s captured.
    let preview: AVCaptureVideoPreviewLayer

    /// The object that manages capture activity and coordinates the flow of data from input devices to capture outputs.
    let session: AVCaptureSession

    /// A dedicated queue for perfroming tasks related to `AVCaptureSession`.
    var sessionQueue = DispatchQueue(label: "com.steppenbeck.VisionCameraDemo.sessionQueue", qos: .userInteractive)

    // MARK:- Methods

    /// Checks user authorization for video access using `AuthorizationManager`.
    /// If authorized, it starts the `AVCaptureSession` iff it is not currently running
    /// and the snapshot state is `false`. Otherwise, does not start running the video.
    func startVideoSession() {
        guard !didSnapPhoto else {
            return
        }

        switch authorizationManager.status {
        case .authorized:
            authorizedStartVideoSession()

        case .notDetermined:
            sessionQueue.suspend()
            authorizationManager.requestAccess { [weak self] _ in
                self?.sessionQueue.resume()
                self?.startVideoSession()
            }

        default:
            delegate?.captureSessionManager(self, didFailWithError: CaptureSessionManagerError.authorization)
        }
    }

    /// Starts the `AVCaptureSession` instance if it is not currently running.
    /// - Important: This method should only be called if video access has been authorized.
    private func authorizedStartVideoSession() {
        assert(authorizationManager.status == .authorized)

        if !session.isRunning {
            sessionQueue.async {
                self.session.startRunning()
            }
        }
    }

    /// Stops the `AVCaptureSession` instance if it is currently running.
    func stopVideoSession() {
        if session.isRunning {
            sessionQueue.async {
                self.session.stopRunning()
            }
        }
    }

    /// Updates the `frame` property of the `AVCaptureVideoPreviewLayer` instance.
    func updatePreviewFrame(_ frame: CGRect) {
        preview.frame = frame
    }

    /// Updates the `sessionPreset` property of the `AVCaptureSession` instance.
    ///
    /// - Parameters:
    ///   - preset: The value to update the `sessionPreset` property of the `AVCaptureSession` instance to.
    ///
    /// - Returns: `true` iff the `AVCaptureSession` was successfully updated; otherwise `false` if the `preset` argument
    /// is already the same as the current `sessionPreset` value, or if the `preset` argument is not supported.
    func updateCaptureSessionPreset(_ preset: AVCaptureSession.Preset) -> Bool {
        guard preset != session.sessionPreset else {
            return false
        }

        if session.canSetSessionPreset(preset) {
            session.sessionPreset = preset
            return true
        } else {
            return false
        }
    }

    // MARK:- Initialization

    init?(preset: AVCaptureSession.Preset = .high, delegate: CaptureSessionManagerDelegate? = nil) {
        self.session = AVCaptureSession()
        self.preview = AVCaptureVideoPreviewLayer(session: session)

        if delegate != nil {
            self.delegate = delegate
        }

        super.init()

        let device: AVCaptureDevice? = {
            if let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first {
                return device
            } else {
                return AVCaptureDevice.default(for: .video)
            }
        }()

        guard device != nil else {
            delegate?.captureSessionManager(self, didFailWithError: CaptureSessionManagerError.device)
            return nil
        }

        let output = AVCaptureVideoDataOutput()
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        output.setSampleBufferDelegate(self, queue: sessionQueue)
        output.alwaysDiscardsLateVideoFrames = true

        session.beginConfiguration() // use to batch multiple configuration operations

        defer {
            session.commitConfiguration()
        }

        guard let input = try? AVCaptureDeviceInput(device: device!), session.canAddInput(input), session.canAddOutput(output) else {
            delegate?.captureSessionManager(self, didFailWithError: CaptureSessionManagerError.device)
            return nil
        }

        session.addInput(input)
        session.addOutput(output)

        if session.canSetSessionPreset(preset) {
            session.sessionPreset = preset
        }

        if preview.connection?.isVideoOrientationSupported == true {
            preview.connection?.videoOrientation = .portrait
        }

        preview.videoGravity = .resizeAspectFill
    }

}

extension CaptureSessionManager: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if didSnapPhoto {
            stopVideoSession()
            self.sampleBuffer = sampleBuffer
        }
    }

}
