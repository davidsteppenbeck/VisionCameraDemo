//
//  AuthorizationManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

/// An `AuthorizationManager` is reponsible for managing the authorization status of an `AVCaptureDevice` for video.
struct AuthorizationManager {

    // MARK:- Properties

    /// The current authorization status of `AVCaptureDevice` for video.
    var status: AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }

    // MARK:- Methods

    /// Requests permission for `AVCaptureDevice` video access.
    ///
    /// - Parameters:
    ///   - completion: A block to be called once permission is granted or denied. The block is called on the main thread.
    func requestAccess(_ completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { permissionGranted in
            DispatchQueue.main.async {
                completion(permissionGranted)
            }
        }
    }

}
