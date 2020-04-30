//
//  UIBarButtonItem+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/30.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    /// A button specialized for placement on a toolbar or tab bar.
    ///
    /// This factory method creates a `UIImage` object containing a system symbol image
    /// using the provided image name.
    ///
    /// - Parameters:
    ///   - systemName: The name of the system symbol image. Use the SF Symbols app to look up the names of system symbol images.
    ///   - style: The style of the item. Defaults to `UIBarButtonItem.Style.plain`.
    ///   - target: The object that receives the `action` message.
    ///   - action: The action to send to `target` when this item is selected.
    ///
    /// - Returns: The `UIBarButtonItem`.
    static func makeForSystemImage(_ systemName: String, style: UIBarButtonItem.Style = .plain, target: Any?, action: Selector?) -> UIBarButtonItem {
        let image = UIImage(systemName: systemName)
        return UIBarButtonItem(image: image, style: style, target: target, action: action)
    }

}
