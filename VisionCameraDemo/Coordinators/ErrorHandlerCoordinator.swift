//
//  ErrorHandlerCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

/// A protocol that is required for coordinators that handle errors.
///
/// This protocol could be used, for example, to present an alert view controller to the user.
protocol ErrorHandlerCoordinator: class {

    /// Call to handle simple errors by presenting an alert to the user.
    ///
    /// The error will be displayed using a basic implementation of `UIAlertController`
    /// that has a single `UIAlertAction` to dismiss the alert.
    ///
    /// - Parameters:
    ///   - error: The error to handle.
    ///   - vc: The view controller that will present the error to the user.
    func handleError(_ error: Error, fromViewController vc: UIViewController)

}

extension ErrorHandlerCoordinator {

    // Provides a default implementation.
    func handleError(_ error: Error, fromViewController vc: UIViewController) {
        let title = NSLocalizedString("UNRESOLVED_ERROR", comment: "Unresolved error.")
        let alert = UIAlertController.simpleAlertController(title: title, message: error.localizedDescription)
        vc.present(alert, animated: true)
    }

}
