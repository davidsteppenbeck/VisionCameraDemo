//
//  CameraViewControllerCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/13.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

protocol CameraViewControllerCoordinator: class {

    /// Call to present the settings table view controller.
    func showSettings()

    /// Call to present the options action sheet.
    func showOptions(from vc: UIViewController, anchor: UIBarButtonItem)

}
