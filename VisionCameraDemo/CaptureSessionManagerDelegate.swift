//
//  CaptureSessionManagerDelegate.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

protocol CaptureSessionManagerDelegate: class {

    /// Called when an error occurs in the `CaptureSessionManager` instance.
    ///
    /// - Parameters:
    ///   - captureSessionManager: The `CaptureSessionManager` in which the error occurred.
    ///   - error: The error that occurred.
    func captureSessionManager(_ captureSessionManager: CaptureSessionManager, didFailWithError error: Error)

}
