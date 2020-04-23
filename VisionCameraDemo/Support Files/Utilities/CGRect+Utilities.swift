//
//  CGRect+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/16.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

extension CGRect {

    /// The center point of the `CGRect`.
    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            origin = CGPoint(x: newValue.x - (size.width * 0.5), y: newValue.y - (size.height * 0.5))
        }
    }

    /// Convenience initializer that uses the `CGRect` center point.
    ///
    /// - Parameters:
    ///   - center: The center point of the rectangle.
    ///   - size: The size of the rectangle.
    ///
    /// - Tag: CGRect.center.init
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - (size.width * 0.5), y: center.y - (size.height * 0.5))
        self.init(origin: origin, size: size)
    }

    /// Scales the `CGRect` and shifts its origin so that its center point remains unchanged.
    ///
    /// - Parameters:
    ///   - scale: The scale factor applied to the rectangle size.
    ///
    /// - Returns: A scaled rectangle with the same center point as the original, created using
    /// the [CGRect(center:size:)](x-source-tag://CGRect.center.init) initializer.
    func scaledAndCentered(_ scale: CGFloat) -> CGRect {
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        return CGRect(center: center, size: scaledSize)
    }

}
