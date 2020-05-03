//
//  CameraModel.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/30.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

final class CameraModel {

    /// Controls whether the camera grid should be displayed to the user.
    @Published var showCameraGrid: Bool

    init(showCameraGrid: Bool) {
        self.showCameraGrid = showCameraGrid
    }

}
