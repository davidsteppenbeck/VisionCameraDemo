//
//  TextRecognitionManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/09.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

/// A protocol for handling OCR text recognition in images and pixel buffers.
///
/// Conforms to the `AVCaptureVideoDataOutputSampleBufferDelegate` protocol.
protocol TextRecognitionManager: AnyObject, AVCaptureVideoDataOutputSampleBufferDelegate {

    /// Keeps a reference to the sample buffer for performing text recognition with snapshots.
    var sampleBuffer: CMSampleBuffer? { get }

    /// The frames of the recognized text in the image, in the coordinate system of the text recognition framework.
    var textBoundingBoxFrames: [CGRect] { get }

}
