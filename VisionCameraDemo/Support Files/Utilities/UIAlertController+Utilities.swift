//
//  UIAlertController+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

extension UIAlertController {

    /// Creates a simple `UIAlertController` with a single action that dismisses the alert.
    ///
    /// - Parameters:
    ///   - title: The title of the alert controller.
    ///   - message: The message (or subtitle) of the alert controller.
    ///   - alertActionText: The title of the alert action button. Defaults to "OK".
    ///
    /// - Returns: A `UIAlertController` instance.
    static func simpleAlertController(title: String, message: String?, alertActionText: String = NSLocalizedString("OK", comment: "OK.")) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: alertActionText, style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }

    /// Creates and returns a `UIAlertController` action sheet style object.
    ///
    /// The alert controller contains a cancel alert action by default.
    ///
    /// - Parameters:
    ///   - title: The title of the alert. Defaults to `nil`.
    ///   - message: Descriptive text that provides additional details about the reason for the alert. Defaults to `nil`.
    ///   - addCancelAction: Whether a standard cancel action should be added. Defaults to `true`.
    ///
    /// - Returns: An initialized action sheet style alert controller object.
    static func makeForActionSheet(title: String? = nil, message: String? = nil, addingCancelAction addCancelAction: Bool = true) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        if addCancelAction {
            alert += UIAlertAction.makeForCancel()
        }

        return alert
    }

    /// Adds an alert action to an alert controller.
    ///
    /// - Parameters:
    ///   - lhs: The alert controller to add the action to.
    ///   - rhs: The alert action to add.
    static func +=(_ lhs: UIAlertController, _ rhs: UIAlertAction) {
        lhs.addAction(rhs)
    }

}
