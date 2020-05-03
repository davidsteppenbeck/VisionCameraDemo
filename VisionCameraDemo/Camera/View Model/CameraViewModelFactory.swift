//
//  CameraViewModelFactory.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/02.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension CameraViewModel {

    /// Creates and returns an instance of `CameraViewModel` by loading parameters from `UserDefaults`.
    static func makeForUserDefaults() -> CameraViewModel {
        let model = CameraModel.makeForUserDefaults()
        return CameraViewModel(model: model)
    }

}
