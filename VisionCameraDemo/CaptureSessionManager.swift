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

    /// The `CaptureSessionManager` delegate object.
    weak var delegate: CaptureSessionManagerDelegate?

    /// Manages the authorization status of an `AVCaptureDevice` for video.
    private let cameraAuthorizationManager: MediaAuthorizationManager = CameraAuthorizationManager()

    /// Handles capturing images and saving them in the Photos app.
    private let photoCaptureDelegate = PhotoCaptureDelegateObject()

    /// Keeps a strong reference to the sample buffer for snapshots.
    private (set) var sampleBuffer: CMSampleBuffer?

    /// Keeps track of the snapshot state: `false` when the video feed is running, otherwise `true`.
    private (set) var didSnapPhoto: Bool = false {
        didSet {
            if didSnapPhoto {
                capturePhoto()
            } else {
                sampleBuffer = nil
            }

            startVideoSession()
        }
    }

    /// The object that manages capture activity and coordinates the flow of data from input devices to capture outputs.
    let session = AVCaptureSession()

    /// A capture output for still images.
    private let photoOutput = AVCapturePhotoOutput()

    /// A serial queue for perfroming all tasks related to `AVCaptureSession`.
    private let sessionQueue = DispatchQueue(label: "com.steppenbeck.VisionCameraDemo.sessionQueue")

    /// A serial queue for perfroming all tasks related to `AVCaptureSession`.
    private let sampleBufferCallbackQueue = DispatchQueue(label: "com.steppenbeck.VisionCameraDemo.sampleBufferCallbackQueue")

    // MARK:- Methods

    /// Toggles the snapshot state.
    func toggle() {
        didSnapPhoto.toggle()
    }

    /// Checks user authorization for video access using `AuthorizationManager`.
    /// If authorized, it starts the `AVCaptureSession` iff it is not currently running
    /// and the snapshot state is `false`. Otherwise, does not start running the video.
    func startVideoSession() {
        assert(Thread.isMainThread)

        guard !didSnapPhoto else {
            return
        }

        switch cameraAuthorizationManager.status {
        case .authorized:
            authorizedStartVideoSession()

        case .notDetermined:
            sessionQueue.suspend()
            cameraAuthorizationManager.requestAccess { [weak self] _ in
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
        assert(cameraAuthorizationManager.status == .authorized)

        sessionQueue.async {
            if !self.session.isRunning {
                DispatchQueue.mainSyncSafe {
                    self.delegate?.captureSessionManagerWillBeginUpdates(self)
                }

                // This method is a blocking call that can take some time, the duration of which depends on the `AVCaptureSession.Preset` quality.
                self.session.startRunning()

                DispatchQueue.mainSyncSafe {
                    self.delegate?.captureSessionManagerDidEndUpdates(self)
                }
            }
        }
    }

    /// Stops the `AVCaptureSession` instance if it is currently running.
    func stopVideoSession() {
        sessionQueue.async {
            if self.session.isRunning {
                DispatchQueue.mainSyncSafe {
                    self.delegate?.captureSessionManagerWillBeginUpdates(self)
                }

                // This method is a blocking call that can take some time, the duration of which depends on the `AVCaptureSession.Preset` quality.
                self.session.stopRunning()

                DispatchQueue.mainSyncSafe {
                    self.delegate?.captureSessionManagerDidEndUpdates(self)
                }
            }
        }
    }

    /// Updates the `sessionPreset` property of the `AVCaptureSession` instance.
    ///
    /// - Parameters:
    ///   - preset: The value to update the `sessionPreset` property of the `AVCaptureSession` instance to.
    ///
    /// - Returns: `true` iff the `AVCaptureSession` was successfully updated; otherwise `false` if the `preset` argument
    /// is already the same as the current `sessionPreset` value, or if the `preset` argument is not supported.
    func updateCaptureSessionPreset(_ preset: AVCaptureSession.Preset) {
        sessionQueue.async {
            guard preset != self.session.sessionPreset else {
                return
            }

            DispatchQueue.mainSyncSafe {
                self.delegate?.captureSessionManagerWillBeginUpdates(self)
            }

            // Assignment can take some time.
            self.session.safeSetSessionPreset(preset)

            DispatchQueue.mainSyncSafe {
                self.delegate?.captureSessionManagerDidEndUpdates(self)
            }
        }
    }

    /// Initiates a photo capture using `AVCapturePhotoOutput`.
    private func capturePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        photoOutput.capturePhoto(with: photoSettings, delegate: photoCaptureDelegate)
    }

    // MARK:- Initialization

    init?(preset: AVCaptureSession.Preset = .high, delegate: CaptureSessionManagerDelegate? = nil) {
        super.init()

        if delegate != nil {
            self.delegate = delegate
        }

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

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        videoOutput.setSampleBufferDelegate(self, queue: sampleBufferCallbackQueue)
        videoOutput.alwaysDiscardsLateVideoFrames = true

        photoOutput.isHighResolutionCaptureEnabled = true
        photoOutput.isLivePhotoCaptureEnabled = false
        photoOutput.isDepthDataDeliveryEnabled = false
        photoOutput.isPortraitEffectsMatteDeliveryEnabled = false
        photoOutput.maxPhotoQualityPrioritization = .balanced

        // Use to batch multiple configuration operations into an atomic update.
        session.beginConfiguration()

        defer {
            // No changes to `session` are applied until calling this.
            session.commitConfiguration()
        }

        guard let deviceInput = try? AVCaptureDeviceInput(device: device!), session.canAddInput(deviceInput), session.canAddOutput(videoOutput), session.canAddOutput(photoOutput) else {
            delegate?.captureSessionManager(self, didFailWithError: CaptureSessionManagerError.device)
            return nil
        }

        session.addInput(deviceInput)
        session.addOutput(videoOutput)
        session.addOutput(photoOutput)
        session.safeSetSessionPreset(preset)
    }

}

extension CaptureSessionManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.main.async {
            if self.didSnapPhoto {
                self.stopVideoSession()

                if self.sampleBuffer == nil {
                    self.sampleBuffer = sampleBuffer
                }
            }
        }
    }
}
