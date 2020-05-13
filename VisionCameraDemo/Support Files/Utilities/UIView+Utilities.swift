//
//  UIView+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/30.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//
//  Code adapted from Simon Nickel [last accessed on 2020/04/30].
//  https://gist.github.com/simonnickel/6eda0448cf3df06b57861068b3cfea4a
//

import UIKit

extension UIView {

    /// The insets of the embedded subview to be applied.
    /// Intended for use with `UIView` instance method [embed(in:)](x-source-tag://UIView.embed).
    struct EmbedInsets {
        let top: CGFloat?
        let bottom: CGFloat?
        let leading: CGFloat?
        let trailing: CGFloat?

        /// - Parameters:
        ///   - top: The top inset. Defaults to `nil`.
        ///   - bottom: The bottom inset. Defaults to `nil`.
        ///   - leading: The leading inset. Defaults to `nil`.
        ///   - trailing: The trailing inset. Defaults to `nil`.
        init(top: CGFloat? = nil, bottom: CGFloat? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil) {
            self.top = top
            self.bottom = bottom
            self.leading = leading
            self.trailing = trailing
        }

        /// An instance that sets all insets to `nil`.
        static let none = EmbedInsets()

        /// An instance that sets all insets to `zero`.
        static let zero = EmbedInsets(top: 0, bottom: 0, leading: 0, trailing: 0)

        /// Provides an instance that sets all insets to the same value.
        /// - Parameter distance: The shared value used for all insets.
        /// - Returns: The `EmbedInsets` instance.
        static func all(_ distance: CGFloat) -> EmbedInsets {
            return EmbedInsets(top: distance, bottom: distance, leading: distance, trailing: distance)
        }
    }

    /// Convenience method that adds the view as a subview to the specified container, and sets its layout constraints.
    ///
    /// The `translatesAutoresizingMaskIntoConstraints` property is automatically set to `false` for all subviews
    /// added. The layout constraints are automatically activated.
    ///
    /// - Parameters:
    ///   - container: The view to embed the subview in.
    ///   - layoutGuide: The layout guide used for setting constraints. Constraints are set relative to the container
    ///   if no layout guide is provided. Defaults to `nil`.
    ///   - insets: The embed insets used for setting constraints. Defaults to `UIView.EmbedInsets.zero`.
    ///   - width: The width of the subview. Defaults to `nil`.
    ///   - height: The height of the subview. Defaults to `nil`.
    ///   - centerXOffset: The horizontal offset of the subview relative to the center point. Defaults to `nil`.
    ///   - centerYOffset: The vertical offset of the subview relative to the center point. Defaults to `nil`.
    ///
    /// - Tag: UIView.embed
    func embed(in container: UIView, using layoutGuide: UILayoutGuide? = nil, insets: EmbedInsets = .zero, width: CGFloat? = nil, height: CGFloat? = nil, centerXOffset: CGFloat? = nil, centerYOffset: CGFloat? = nil) {

        // Add the view on top of all other subviews.
        container.addSubview(self)

        // Apply autolayout constraints.
        applyLayoutConstraints(in: container, using: layoutGuide, insets: insets, width: width, height: height, centerXOffset: centerXOffset, centerYOffset: centerYOffset)
    }

    /// Convenience method that adds the view as a subview to the specified container, and sets its layout constraints.
    ///
    /// The `translatesAutoresizingMaskIntoConstraints` property is automatically set to `false` for all subviews
    /// added. The layout constraints are automatically activated.
    ///
    /// - Parameters:
    ///   - container: The view to embed the subview in.
    ///   - index: The index in the array of the subviews property at which to insert the view.
    ///   - layoutGuide: The layout guide used for setting constraints. Constraints are set relative to the container
    ///   if no layout guide is provided. Defaults to `nil`.
    ///   - insets: The embed insets used for setting constraints. Defaults to `UIView.EmbedInsets.zero`.
    ///   - width: The width of the subview. Defaults to `nil`.
    ///   - height: The height of the subview. Defaults to `nil`.
    ///   - centerXOffset: The horizontal offset of the subview relative to the center point. Defaults to `nil`.
    ///   - centerYOffset: The vertical offset of the subview relative to the center point. Defaults to `nil`.
    func embed(in container: UIView, at index: Int, using layoutGuide: UILayoutGuide? = nil, insets: EmbedInsets = .zero, width: CGFloat? = nil, height: CGFloat? = nil, centerXOffset: CGFloat? = nil, centerYOffset: CGFloat? = nil) {

        // Insert the view at the specified index, if applicable. Otherwise add it on top of all other subviews.
        if container.subviews.indices.contains(index) {
            container.insertSubview(self, at: index)
        } else {
            container.addSubview(self)
        }

        // Apply autolayout constraints.
        applyLayoutConstraints(in: container, using: layoutGuide, insets: insets, width: width, height: height, centerXOffset: centerXOffset, centerYOffset: centerYOffset)
    }

    /// Convenience method that adds the view as a subview to the specified container, and sets its layout constraints.
    ///
    /// The `translatesAutoresizingMaskIntoConstraints` property is automatically set to `false` for all subviews
    /// added. The layout constraints are automatically activated.
    ///
    /// - Parameters:
    ///   - container: The view to embed the subview in.
    ///   - siblingSubview: The sibling view that will be above the inserted view.
    ///   - layoutGuide: The layout guide used for setting constraints. Constraints are set relative to the container
    ///   if no layout guide is provided. Defaults to `nil`.
    ///   - insets: The embed insets used for setting constraints. Defaults to `UIView.EmbedInsets.zero`.
    ///   - width: The width of the subview. Defaults to `nil`.
    ///   - height: The height of the subview. Defaults to `nil`.
    ///   - centerXOffset: The horizontal offset of the subview relative to the center point. Defaults to `nil`.
    ///   - centerYOffset: The vertical offset of the subview relative to the center point. Defaults to `nil`.
    func embed(in container: UIView, belowSubview siblingSubview: UIView, using layoutGuide: UILayoutGuide? = nil, insets: EmbedInsets = .zero, width: CGFloat? = nil, height: CGFloat? = nil, centerXOffset: CGFloat? = nil, centerYOffset: CGFloat? = nil) {

        // Insert the view below the specified subview, if applicable. Otherwise add it on top of all other subviews.
        if container.subviews.contains(siblingSubview) {
            container.insertSubview(self, belowSubview: siblingSubview)
        } else {
            container.addSubview(self)
        }

        // Apply autolayout constraints.
        applyLayoutConstraints(in: container, using: layoutGuide, insets: insets, width: width, height: height, centerXOffset: centerXOffset, centerYOffset: centerYOffset)
    }

    private func applyLayoutConstraints(in container: UIView, using layoutGuide: UILayoutGuide? = nil, insets: EmbedInsets = .zero, width: CGFloat? = nil, height: CGFloat? = nil, centerXOffset: CGFloat? = nil, centerYOffset: CGFloat? = nil) {

        // Ensure no autolayout constraint conflicts occur.
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }

        if let top = insets.top {
            topAnchor.constraint(equalTo: layoutGuide?.topAnchor ?? container.topAnchor, constant: top).isActive = true
        }

        if let bottom = insets.bottom {
            bottomAnchor.constraint(equalTo: layoutGuide?.bottomAnchor ?? container.bottomAnchor, constant: -bottom).isActive = true
        }

        if let leading = insets.leading {
            leadingAnchor.constraint(equalTo: layoutGuide?.leadingAnchor ?? container.leadingAnchor, constant: leading).isActive = true
        }

        if let trailing = insets.trailing {
            trailingAnchor.constraint(equalTo: layoutGuide?.trailingAnchor ?? container.trailingAnchor, constant: -trailing).isActive = true
        }

        if let centerXOffset = centerXOffset {
            centerXAnchor.constraint(equalTo: layoutGuide?.centerXAnchor ?? container.centerXAnchor, constant: centerXOffset).isActive = true
        }

        if let centerYOffset = centerYOffset {
            centerYAnchor.constraint(equalTo: layoutGuide?.centerYAnchor ?? container.centerYAnchor, constant: centerYOffset).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

}
