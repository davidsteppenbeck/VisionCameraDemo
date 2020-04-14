//
//  CALayer+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/13.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

extension CALayer {
    func addSublayer(_ layer: CALayer?) {
        if let layer = layer {
            addSublayer(layer)
        }
    }
}
