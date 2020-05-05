//
//  AVCaptureSession+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/22.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

extension AVCaptureSession {

    /// Safely assigns the `sessionPreset` property.
    ///
    /// The assignment will only be made if the `canSetSessionPreset(_:)` method returns `true`.
    /// If the preferred preset is not supported on the device then the default value will be applied.
    ///
    /// - Parameters:
    ///   - preset: The preferred `AVCaptureSession.Preset` value to be assigned.
    func safeSetSessionPreset(_ preset: AVCaptureSession.Preset) {
        if canSetSessionPreset(preset) {

            // The preferred preset is supported. Apply it, but only if it's not already set.
            if preset != sessionPreset { sessionPreset = preset }

        } else if canSetSessionPreset(VideoResolution.defaultValue.preset) {

            // The preferred preset could not be set. Apply the default value, but only if it's not already set.
            if VideoResolution.defaultValue.preset != sessionPreset {
                sessionPreset = VideoResolution.defaultValue.preset
            }
        }
    }

}
