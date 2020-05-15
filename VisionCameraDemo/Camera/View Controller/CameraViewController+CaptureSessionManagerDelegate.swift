//
//  CameraViewController+CaptureSessionManagerDelegate.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

// Satisfy conformance to the `CaptureSessionManagerDelegate` protocol.
extension CameraViewController: CaptureSessionManagerDelegate {

    func captureSessionManager(_ captureSessionManager: CaptureSessionManager, didFailWithError error: Error) {
        coordinator?.handleError(error, fromViewController: self)
    }

}
