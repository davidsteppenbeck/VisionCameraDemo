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

    /// Whether snapshots will be persisted using `AVCapturePhotoOutput`. The value is controlled by user settings.
    private var saveSnapshots: Bool

    /// Manages the authorization status of an `AVCaptureDevice` for video.
    private let cameraAuthorizationManager: MediaAuthorizationManager = CameraAuthorizationManager()

    /// Handles capturing images and saving them in the Photos app.
    private let photoCaptureDelegate: AVCapturePhotoCaptureDelegate = PhotoCaptureDelegate()

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

    /// Initiates a photo capture using `AVCapturePhotoOutput`.
    private func capturePhoto() {
        guard saveSnapshots else {
            // Play sound manually because `AVCapturePhotoOutput` is denied.
            AudioSessionManager.playSound(withStyle: .cameraShutter)
            return
        }

        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        photoOutput.capturePhoto(with: photoSettings, delegate: photoCaptureDelegate)
    }

    /// Adds `NotificationCenter` observers.
    func addNotificationCenterObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateSaveSnapshots(_:)), name: .saveSnapshots, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCaptureSessionPreset(_:)), name: .videoResolution, object: nil)
    }

    /// Removes `NotificationCenter` observers.
    func removeNotificationCenterObservers() {
        NotificationCenter.default.removeObserver(self, name: .saveSnapshots, object: nil)
        NotificationCenter.default.removeObserver(self, name: .videoResolution, object: nil)
    }

    // MARK:- Actions

    /// Updates the `saveSnapshots` property.
    @objc private func updateSaveSnapshots(_ notification: Notification) {

        // Uses the notification name as the dictionary key.
        guard let saveSnapshots = notification.userInfo?[notification.name] as? Bool else {
            return
        }

        if saveSnapshots != self.saveSnapshots {
            self.saveSnapshots = saveSnapshots
        }
    }

    /// Updates the `sessionPreset` property of the `AVCaptureSession` instance.
    @objc func updateCaptureSessionPreset(_ notification: Notification) {

        // Uses the notification name as the dictionary key.
        guard let videoResolution = notification.userInfo?[notification.name] as? VideoResolution else {
            return
        }

        sessionQueue.async {
            DispatchQueue.mainSyncSafe {
                self.delegate?.captureSessionManagerWillBeginUpdates(self)
            }

            // Assignment can take some time.
            self.session.safeSetSessionPreset(videoResolution.preset)

            DispatchQueue.mainSyncSafe {
                self.delegate?.captureSessionManagerDidEndUpdates(self)
            }
        }
    }

    // MARK:- Initialization

    init?(videoResolution: VideoResolution, saveSnapshots: Bool, delegate: CaptureSessionManagerDelegate? = nil) {
        self.saveSnapshots = saveSnapshots
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
        session.safeSetSessionPreset(videoResolution.preset)

        // Add notification center observers because the setup was successful.
        addNotificationCenterObservers()
    }

    // MARK:- Deinitialization

    deinit {
        removeNotificationCenterObservers()
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
