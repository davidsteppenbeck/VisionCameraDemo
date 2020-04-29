//
//  CameraViewControllerCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/13.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

protocol CameraViewControllerCoordinator: class {

    /// Call to present settings table view controller.
    func showSettings()

    /// Call to present options action sheet.
    func showOptions()

}
