//
//  UIAlertViewController+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/05.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

extension UIAlertController {

    /// Creates and returns a `UIAlertController` action sheet style object.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: Descriptive text that provides additional details about the reason for the alert.
    ///
    /// Returns: An initialized action sheet style alert controller object.
    static func makeForActionSheet(title: String? = nil, message: String? = nil) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }

    /// Adds an alert action to an alert controller.
    ///
    /// - Parameters:
    ///   - lhs: The alert controller to add the action to.
    ///   - rhs: The alert action to add.
    static func += (_ lhs: UIAlertController, _ rhs: UIAlertAction) {
        lhs.addAction(rhs)
    }

}
