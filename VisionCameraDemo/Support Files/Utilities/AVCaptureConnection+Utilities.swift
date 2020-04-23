//
//  AVCaptureConnection+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/22.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

extension AVCaptureConnection {

    /// Safely assigns the `videoOrientation` property.
    ///
    /// The assignment will only be made if the `isVideoOrientationSupported` property is `true`.
    ///
    /// - Parameters:
    ///   - orientation: The `AVCaptureVideoOrientation` value to be assigned.
    func safeSetVideoOrientation(_ orientation: AVCaptureVideoOrientation) {
        if isVideoOrientationSupported {
            videoOrientation = orientation
        }
    }

    /// Safely assigns the `preferredVideoStabilizationMode` property.
    ///
    /// The assignment will only be made if the `isVideoStabilizationSupported` property is `true`.
    ///
    /// - Parameters:
    ///   - mode: The `AVCaptureVideoStabilizationMode` value to be assigned.
    func safeSetVideoStabilizationMode(_ mode: AVCaptureVideoStabilizationMode) {
        if isVideoStabilizationSupported {
            preferredVideoStabilizationMode = mode
        }
    }

}
