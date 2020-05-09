//
//  CaptureSessionManagerError.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

/// Errors thrown by `CaptureSessionManager`.
enum CaptureSessionManagerError: Error, LocalizedError {

    /// An error occurred whilst trying to set up the `AVCaptureDevice`.
    case device

    /// Access to `AVCaptureDevice` for video has not been authorized.
    case authorization

    var errorDescription: String? {
        switch self {
        case .device: return NSLocalizedString("NO_DEVICE_CAMERA_ERROR_DESCRIPTION", comment: "Unable to find or set up the device camera.")
        case .authorization: return NSLocalizedString("UNAUTHORIZED_ACCESS_DEVICE_CAMERA_ERROR_DESCRIPTION", comment: "The app is not authorized to access the device camera.")
        }
    }

}
