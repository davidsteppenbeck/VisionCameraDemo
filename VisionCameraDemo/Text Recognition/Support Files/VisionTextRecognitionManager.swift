//
//  VisionTextRecognitionManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/09.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation
import Vision

/// A class that uses the `Vision` framework to handle OCR text recognition in images and pixel buffers.
final class VisionTextRecognitionManager: NSObject, TextRecognitionManager {

    // MARK:- Properties

    // Required for conformance to the `TextRecognitionManager` protocol.
    @Published private(set) var textBoundingBoxFrames = [CGRect]() {
        didSet {
            // Mark the image processing state as inactive each time the array is updated.
            imageProcessingState = .inactive
        }
    }

    /// Keeps track of the image processing state.
    private(set) var imageProcessingState: ImageProcessingState = .inactive

    // Required for conformance to the `TextRecognitionManager` protocol.
    private(set) var sampleBuffer: CMSampleBuffer? {
        didSet {
            detectAllText(in: sampleBuffer)
        }
    }

    /// Controls the parameters for the OCR text recognition request.
    ///
    /// This demo app only provides "fast" text recognition with no language correction
    /// because the images from the sample buffer are processed in real time.
    private lazy var recognizeTextRequest: VNRecognizeTextRequest = {
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextRequestCompletionHandler)
        request.recognitionLevel = .fast
        request.revision = VNRecognizeTextRequestRevision1
        request.usesLanguageCorrection = false
        request.minimumTextHeight = 0.05
        request.usesCPUOnly = false
        return request
    }()

    // MARK:- AVCaptureVideoDataOutputSampleBufferDelegate

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.main.async {
            self.sampleBuffer = sampleBuffer
        }
    }

    // MARK:- Methods

    /// Performs OCR text recognition on the provided sample buffer.
    private func detectAllText(in sampleBuffer: CMSampleBuffer?) {

        // Ensure that no previous call is still being processed.
        guard imageProcessingState.isInactive else {
            return
        }

        // Mark the state as being actively processed.
        imageProcessingState = .active

        // OCR text recognition can take some time. Ensure it's done off the main thread.
        DispatchQueue.global(qos: .userInitiated).async {

            /// Call this method to clear the `textBoundingBoxFrames` array on the main thread if an error occurs.
            func resetTextBoundingBoxFrames() {
                DispatchQueue.main.async {
                    self.textBoundingBoxFrames.removeAll()
                }
            }

            // An image buffer is required for OCR processing.
            guard let sampleBuffer = sampleBuffer, let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
                resetTextBoundingBoxFrames()
                return
            }

            let requests: [VNRequest] = [self.recognizeTextRequest]
            let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:])

            do {
                // Calls the completion handler if image processing is successful.
                try requestHandler.perform(requests)
            } catch {
                // TODO: Check that the completion handler is not called if an error is thrown.
                resetTextBoundingBoxFrames()
                return
            }
        }
    }

    /// The completion handler for the `VNRecognizeTextRequest` object.
    private func recognizeTextRequestCompletionHandler(_ request: VNRequest, _ error: Error?) {
        DispatchQueue.main.async {
            guard error == nil, let observations = request.results as? [VNRecognizedTextObservation] else {
                self.textBoundingBoxFrames.removeAll()
                return
            }

            // Successfully obtained new bounding boxes, so assign their values.
            self.textBoundingBoxFrames = observations.map { $0.boundingBox }
        }
    }

}
