//
//  CaptureSessionManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/13.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation
import Combine

/// A `CaptureSessionManager` is reponsible for setting up and managing the flow of an `AVCaptureSession` instance.
final class CaptureSessionManager: NSObject, CameraCaptureSessionManagerConvertible {

    // MARK:- Properties

    /// The `CaptureSessionManager` delegate object.
    weak var delegate: CaptureSessionManagerDelegate?

    /// Whether snapshots will be persisted using `AVCapturePhotoOutput`. The value is controlled by user settings.
    private var saveSnapshots: Bool

    /// Manages the authorization status of an `AVCaptureDevice` for video.
    private let cameraAuthorizationManager: MediaAuthorizationManager = CameraAuthorizationManager()

    /// Handles capturing images and saving them in the Photos app.
    private let photoCaptureDelegate: AVCapturePhotoCaptureDelegate = PhotoCaptureDelegate()

    /// Keeps track of the snapshot state. The value is `true` when the video feed has stopped running, otherwise `false`.
    private(set) var didSnapPhoto: Bool = false {
        didSet {
            if didSnapPhoto {
                capturePhoto()
                stopVideoSession()
            } else {
                startVideoSession()
            }
        }
    }

    // Required for conformance to the `CameraCaptureSessionManagerConvertible` protocol.
    let captureSession = CameraCaptureSession()

    // Required for conformance to the `CameraCaptureSessionManagerConvertible` protocol.
    let videoOutput = AVCaptureVideoDataOutput()

    /// A capture output for still images.
    private let photoOutput = AVCapturePhotoOutput()

    /// A serial queue for perfroming all tasks related to `AVCaptureSession`.
    private let sessionQueue = DispatchQueue(label: "com.steppenbeck.VisionCameraDemo.sessionQueue")

    /// A serial queue for perfroming all tasks related to `AVCaptureSession`.
    private let sampleBufferCallbackQueue = DispatchQueue(label: "com.steppenbeck.VisionCameraDemo.sampleBufferCallbackQueue")

    /// An array to keep references to `AnyCancellable` subscribers.
    private var subscriptions = [AnyCancellable]()

    // MARK:- Methods

    // Required for conformance to the `CameraCaptureSessionManagerConvertible` protocol.
    func toggleVideoSession() {
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
            if !self.captureSession.isRunning {
                DispatchQueue.mainSyncSafe {
                    self.captureSession.isUpdatingCaptureSession = true
                }

                // This method is a blocking call that can take some time, the duration of which depends on the `AVCaptureSession.Preset` quality.
                self.captureSession.startRunning()

                DispatchQueue.mainSyncSafe {
                    self.captureSession.isUpdatingCaptureSession = false
                }
            }
        }
    }

    /// Stops the `AVCaptureSession` instance if it is currently running.
    func stopVideoSession() {
        sessionQueue.async {
            if self.captureSession.isRunning {
                DispatchQueue.mainSyncSafe {
                    self.captureSession.isUpdatingCaptureSession = true
                }

                // This method is a blocking call that can take some time, the duration of which depends on the `AVCaptureSession.Preset` quality.
                self.captureSession.stopRunning()

                DispatchQueue.mainSyncSafe {
                    self.captureSession.isUpdatingCaptureSession = false
                }
            }
        }
    }

    // Required for conformance to the `CameraCaptureSessionManagerConvertible` protocol.
    func setSampleBufferDelegate(_ sampleBufferDelegate: AVCaptureVideoDataOutputSampleBufferDelegate?) {
        videoOutput.setSampleBufferDelegate(sampleBufferDelegate, queue: sampleBufferCallbackQueue)
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

    /// Adds subscribers to `NotificationCenter` publishers.
    private func addNotificationCenterSubscribers() {
        NotificationCenter.Publisher(center: .default, name: .saveSnapshots)
            .compactMap { (notification) -> Bool? in
                return notification.userInfo?[notification.name] as? Bool
            }
            .assign(to: \.saveSnapshots, on: self)
            .store(in: &subscriptions)

        NotificationCenter.Publisher(center: .default, name: .videoResolution)
            .compactMap { (notification) -> VideoResolution? in
                return notification.userInfo?[notification.name] as? VideoResolution
            }
            .map { videoResolution in
                return videoResolution.preset
            }
            .sink { [weak self] preset in
                self?.updateCaptureSessionPreset(preset)
            }
            .store(in: &subscriptions)
    }

    /// Updates the `sessionPreset` property of the `AVCaptureSession` instance.
    private func updateCaptureSessionPreset(_ preset: AVCaptureSession.Preset) {
        sessionQueue.async {
            DispatchQueue.mainSyncSafe {
                self.captureSession.isUpdatingCaptureSession = true
            }

            // Assignment can take some time.
            self.captureSession.safeSetSessionPreset(preset)

            DispatchQueue.mainSyncSafe {
                self.captureSession.isUpdatingCaptureSession = false
            }
        }
    }

    // MARK:- Initialization

    init?(videoResolution: VideoResolution, saveSnapshots: Bool, delegate: CaptureSessionManagerDelegate? = nil, sampleBufferDelegate: AVCaptureVideoDataOutputSampleBufferDelegate? = nil) {
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

        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        videoOutput.alwaysDiscardsLateVideoFrames = true

        // Set the `videoOutput` sample buffer delegate.
        setSampleBufferDelegate(sampleBufferDelegate)

        photoOutput.isHighResolutionCaptureEnabled = true
        photoOutput.isLivePhotoCaptureEnabled = false
        photoOutput.isDepthDataDeliveryEnabled = false
        photoOutput.isPortraitEffectsMatteDeliveryEnabled = false
        photoOutput.maxPhotoQualityPrioritization = .balanced

        // Use to batch multiple configuration operations into an atomic update.
        captureSession.beginConfiguration()

        defer {
            // No changes to `captureSession` are applied until commiting the configuration.
            captureSession.commitConfiguration()
        }

        guard let deviceInput = try? AVCaptureDeviceInput(device: device!), captureSession.canAddInput(deviceInput), captureSession.canAddOutput(videoOutput), captureSession.canAddOutput(photoOutput) else {
            delegate?.captureSessionManager(self, didFailWithError: CaptureSessionManagerError.device)
            return nil
        }

        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)
        captureSession.addOutput(photoOutput)
        captureSession.safeSetSessionPreset(videoResolution.preset)

        // Add notification center subscribers because the setup was successful.
        addNotificationCenterSubscribers()
    }

}
