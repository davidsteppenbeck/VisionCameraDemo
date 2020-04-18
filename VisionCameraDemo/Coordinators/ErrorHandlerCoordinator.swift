//
//  ErrorHandlerCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

protocol ErrorHandlerCoordinator: class {

    /// Call to handle simple errors by presenting an alert to the user.
    func handleError(_ error: Error, fromViewController vc: UIViewController)

}
