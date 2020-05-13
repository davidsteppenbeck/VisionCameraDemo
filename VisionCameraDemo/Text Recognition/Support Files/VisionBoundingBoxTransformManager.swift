//
//  VisionBoundingBoxTransformManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/13.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

/// Transforms bounding boxes provided by the `Vision` framework.
struct VisionBoundingBoxTransformManager: BoundingBoxTransformManager {

    let portraitTransform: CGAffineTransform = {

        /// Transforms bottom left coordinates to top left.
        let inversionTransform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)

        /// Transforms user interface coordinates to the `AVCaptureMetadataOutput` coordinate system.
        let rotationTransform = CGAffineTransform(translationX: 0, y: 1).rotated(by: -CGFloat.pi / 2)

        return CGAffineTransform.identity
            .concatenating(inversionTransform)
            .concatenating(rotationTransform)

    }()

}
