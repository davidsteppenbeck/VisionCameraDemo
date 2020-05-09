//
//  UIAlertAction+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/05.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

extension UIAlertAction {

    /// Creates and returns an alert action with the cancel title and style, and no completion handler.
    static func makeForCancel() -> UIAlertAction {
        let title = NSLocalizedString("CANCEL", comment: "Cancel.")
        return UIAlertAction(title: title, style: .cancel, handler: nil)
    }

}
