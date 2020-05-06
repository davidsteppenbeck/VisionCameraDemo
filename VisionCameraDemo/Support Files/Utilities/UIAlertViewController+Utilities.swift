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
    /// The alert controller contains a cancel alert action by default.
    ///
    /// - Parameters:
    ///   - title: The title of the alert. Defaults to `nil`.
    ///   - message: Descriptive text that provides additional details about the reason for the alert. Defaults to `nil`.
    ///   - addCancelAction: Whether a standard cancel action should be added. Defaults to `true`.
    ///
    /// Returns: An initialized action sheet style alert controller object.
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
    static func += (_ lhs: UIAlertController, _ rhs: UIAlertAction) {
        lhs.addAction(rhs)
    }

    /// Configures the alert's popover presentation controller.
    ///
    /// - Parameters:
    ///   - sourceView: The view containing the anchor rectangle for the popover.
    ///   - sourceRect: The rectangle in the specified view in which to anchor the popover. If the parameter is `nil`,
    ///   then the `sourceView`'s bounds will be used. Defaults to `nil`.
    ///   - permittedArrowDirections: The arrow directions that you allow for the popover. Defaults to `UIPopoverArrowDirection.any`.
    func configurePopover(sourceView: UIView, sourceRect: CGRect? = nil, permittedArrowDirections: UIPopoverArrowDirection = .any) {
        guard let popover = popoverPresentationController else {
            return
        }

        popover.sourceView = sourceView
        popover.sourceRect = sourceRect ?? sourceView.bounds
        popover.permittedArrowDirections = permittedArrowDirections
        popover.canOverlapSourceViewRect = true
    }

}
