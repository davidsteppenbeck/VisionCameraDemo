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
        case .device: return "Unable to find or set up the device camera."
        case .authorization: return "The app is not authorized to access the device camera."
        }
    }

}
