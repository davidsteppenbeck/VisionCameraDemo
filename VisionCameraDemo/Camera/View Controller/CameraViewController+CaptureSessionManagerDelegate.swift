//
//  CameraViewController+CaptureSessionManagerDelegate.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension CameraViewController: CaptureSessionManagerDelegate {

    func captureSessionManager(_ captureSessionManager: CaptureSessionManager, didFailWithError error: Error) {
        coordinator?.handleError(error, fromViewController: self)
    }

    func captureSessionManagerWillBeginUpdates(_ captureSessionManager: CaptureSessionManager) {
        cameraButton.isEnabled = false // TODO: Replace with Combine solution.
    }

    func captureSessionManagerDidEndUpdates(_ captureSessionManager: CaptureSessionManager) {
        cameraButton.isEnabled = true // TODO: Replace with Combine solution.
    }

}
