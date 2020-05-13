//
//  BoundingBoxTransformManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/11.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

/// Transforms text bounding boxes provided by the OCR text recognition framework
/// into the `AVCaptureMetadataOutput` coordinate system.
protocol BoundingBoxTransformManager {

    /// The transform to apply for portrait device orientation.
    var portraitTransform: CGAffineTransform { get }

}
