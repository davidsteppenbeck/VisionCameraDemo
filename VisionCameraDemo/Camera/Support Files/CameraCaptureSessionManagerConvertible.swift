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

    /// A capture output that records video and provides access to video frames for processing.
    /// - Tag: CameraCaptureSessionManagerConvertible.videoOutput
    var videoOutput: AVCaptureVideoDataOutput { get }

    /// Tells the capture session to start running.
    func startVideoSession()

    /// Tells the capture session to stop running.
    func stopVideoSession()

    /// Toggles the state of the capture session.
    func toggleVideoSession()

    /// Sets the sample buffer delegate for the [videoOutput](x-source-tag://CameraCaptureSessionManagerConvertible.videoOutput) object.
    ///
    /// - Parameters:
    ///   - sampleBufferDelegate: The sample buffer delegate to assign.
    func setSampleBufferDelegate(_ sampleBufferDelegate: AVCaptureVideoDataOutputSampleBufferDelegate?)

}
