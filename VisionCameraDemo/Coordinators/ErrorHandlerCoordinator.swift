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
    ///
    /// The error will be displayed using a basic implementation of `UIAlertController`
    /// that has a single `UIAlertAction` to dismiss the alert.
    ///
    /// - Parameters:
    ///   - error: The error to handle.
    ///   - vc: The view controller that will display the error to the user.
    func handleError(_ error: Error, fromViewController vc: UIViewController)

}

extension ErrorHandlerCoordinator {

    func handleError(_ error: Error, fromViewController vc: UIViewController) {
        let alert = UIAlertController.simpleAlertController(title: "Unresolved Error", message: error.localizedDescription)
        vc.present(alert, animated: true)
    }

}
