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

    /// Called before changes to `AVCaptureSession` are applied.
    ///
    /// - Parameters:
    ///   - captureSessionManager: The `CaptureSessionManager` in which the updates will occur.
    ///
    /// Changes to `AVCaptureSession` can take some time, so use this method to disble related UI
    /// elements to prevent changing the state of `AVCaptureSession` while it's already in the process of being updated.
    func captureSessionManagerWillBeginUpdates(_ captureSessionManager: CaptureSessionManager)

    /// Called after changes to `AVCaptureSession` are finished.
    ///
    /// - Parameters:
    ///   - captureSessionManager: The `CaptureSessionManager` in which the updates occurred.
    func captureSessionManagerDidEndUpdates(_ captureSessionManager: CaptureSessionManager)

}
