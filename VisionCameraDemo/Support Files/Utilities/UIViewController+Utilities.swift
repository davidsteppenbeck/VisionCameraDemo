//
//  UIViewController+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/06.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

extension UIViewController {

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

    /// Configures the alert's popover presentation controller.
    ///
    /// - Parameters:
    ///   - anchor: The bar button item on which to anchor the popover.
    ///   - permittedArrowDirections: The arrow directions that you allow for the popover. Defaults to `UIPopoverArrowDirection.any`.
    func configurePopover(anchor: UIBarButtonItem, permittedArrowDirections: UIPopoverArrowDirection = .any) {
        guard let popover = popoverPresentationController else {
            return
        }

        popover.barButtonItem = anchor
        popover.permittedArrowDirections = permittedArrowDirections
        popover.canOverlapSourceViewRect = false
    }

}
