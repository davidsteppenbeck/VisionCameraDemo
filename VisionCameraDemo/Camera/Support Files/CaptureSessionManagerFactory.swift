//
//  CaptureSessionManagerFactory.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/02.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

extension CaptureSessionManager {

    /// Creates a `CaptureSessionManager` instance using initialization parameters from `UserDefaults`.
    ///
    /// - Parameters:
    ///   - delegate: The delegate for the `CaptureSessionManager` object. Defaults to `nil`.
    ///   - sampleBufferDelegate: The delegate for the `AVCaptureVideoDataOutput` object. Defaults to `nil`.
    ///
    /// - Returns: The capture session manager object, if initialization was successful. Otherwise returns `nil`.
    static func makeForUserDefaults(delegate: CaptureSessionManagerDelegate? = nil, sampleBufferDelegate: AVCaptureVideoDataOutputSampleBufferDelegate? = nil) -> CaptureSessionManager? {
        return CaptureSessionManager(
            videoResolution: UserDefaults.videoResolution,
            saveSnapshots: UserDefaults.saveSnapshots,
            delegate: delegate,
            sampleBufferDelegate: sampleBufferDelegate
        )
    }

}
