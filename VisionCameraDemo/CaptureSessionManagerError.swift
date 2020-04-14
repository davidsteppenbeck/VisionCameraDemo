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

    var errorDescription: String? {
        switch self {
        case .device: return "Unable to set up the device camera."
        }
    }

}
