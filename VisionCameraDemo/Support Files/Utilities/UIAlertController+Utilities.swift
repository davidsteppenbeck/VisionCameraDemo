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
    static func simpleAlertController(title: String, message: String?, alertActionText: String = "OK") -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: alertActionText, style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }

}
