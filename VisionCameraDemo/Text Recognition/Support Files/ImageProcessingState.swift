//
//  ImageProcessingState.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/12.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

/// Provides image processing states for OCR text recognition.
enum ImageProcessingState {

    /// The text recognition framework is currently processing an image.
    /// Use this state to prevent processing any other images until it's done.
    case processing

    /// The text recognition process is not currently processing an image.
    case inactive

    /// Whether the image processing state is currently active.
    var isProcessing: Bool {
        return self == .processing
    }

    /// Whether the image processing state is currently inactive.
    var isInactive: Bool {
        return self == .inactive
    }

}
