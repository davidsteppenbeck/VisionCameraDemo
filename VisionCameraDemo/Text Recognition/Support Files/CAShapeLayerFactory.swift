//
//  CAShapeLayerFactory.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/11.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

extension CAShapeLayer {

    /// Creates a new `TextBoundingBox` for display.
    ///
    /// - Parameters:
    ///   - frame: The frame to apply to the bounding box.
    ///   - borderColor: The color to apply to the border. Defaults to `UIColor.systemYellow`.
    ///   - borderWidth: The width to apply to the border.
    ///
    /// - Returns: The text bounding box layer.
    static func makeForTextBoundingBox(frame: CGRect, borderColor: UIColor = .systemYellow, borderWidth: CGFloat = 2) -> TextBoundingBox {
        let layer = CAShapeLayer()
        layer.frame = frame
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        return layer
    }

}
