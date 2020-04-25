//
//  MediaAuthorizationManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/25.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

/// A `MediaAuthorizationManager` is reponsible for managing the authorization status of a media device.
protocol MediaAuthorizationManager {

    /// The current authorization status of the media capture device.
    var status: AVAuthorizationStatus { get }

    /// Requests permission for access to the media device.
    ///
    /// - Parameters:
    ///   - completion: A block to be called once permission is either granted or denied.
    func requestAccess(_ completion: @escaping (Bool) -> Void)

}
