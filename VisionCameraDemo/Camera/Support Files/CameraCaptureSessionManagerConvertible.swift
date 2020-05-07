//
//  CameraCaptureSessionManagerConvertible.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/07.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

protocol CameraCaptureSessionManagerConvertible: class {

    /// An object that manages capture activity and coordinates the flow of data from input devices to capture outputs.
    var captureSession: CameraCaptureSession { get }

    /// Tells the capture session to start running.
    func startVideoSession()

    /// Tells the capture session to stop running.
    func stopVideoSession()

    /// Toggles the capture session's running state.
    func toggle()

}
