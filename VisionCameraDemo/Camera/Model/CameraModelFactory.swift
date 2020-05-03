//
//  CameraModelFactory.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/30.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension CameraModel {

    /// Creates and returns an instance of `CameraModel` by loading parameters from `UserDefaults`.
    static func makeForUserDefaults() -> CameraModel {
        return CameraModel(showCameraGrid: UserDefaults.showCameraGrid)
    }

}
