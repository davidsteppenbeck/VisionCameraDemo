//
//  CameraCaptureSession.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/06.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

protocol UpdateableCaptureSession: class {

    /// Whether the capture session is currently updating.
    ///
    /// Session updates may take some time, so use this property's state to perform any updates
    /// that are required whilst the session changes. For example, some UI elements could be disabled
    /// whilst the updates are in progress.
    var isUpdatingSession: Bool { get set }

}

final class CameraCaptureSession: AVCaptureSession, UpdateableCaptureSession {

    @Published var isUpdatingSession = false

}
