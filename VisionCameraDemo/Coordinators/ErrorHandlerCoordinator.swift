//
//  ErrorHandlerCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

protocol ErrorHandlerCoordinator: class {
    func handleError(_ error: Error, fromViewController vc: UIViewController)
}
