//
//  CameraGridView.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/29.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

/// Renders a simple and configurable grid.
final class CameraGridView: UIView {

    // MARK:- Properties

    /// The alpha value used for grid lines.
    private let lineAlpha: CGFloat

    /// The width of the grid lines.
    private let lineWidth: CGFloat

    /// The number of vertical grid lines to render.
    private let numberOfVerticalLines: Int

    /// The number of horizontal grid lines to render.
    private let numberOfHorizontalLines: Int

    /// The view's width. Returns `self.bounds.size.width`.
    private var viewWidth: CGFloat {
        return self.bounds.size.width
    }

    /// The view's height. Returns `self.bounds.size.height`.
    private var viewHeight: CGFloat {
        return self.bounds.size.height
    }

    // MARK:- Drawing

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let path = UIBezierPath()
        let verticalLineSpacing = viewWidth / CGFloat(numberOfVerticalLines + 1)
        let horizontalLineSpacing = viewHeight / CGFloat(numberOfHorizontalLines + 1)

        for index in 1...numberOfVerticalLines {
            let position = CGFloat(index) * verticalLineSpacing
            addVerticalLine(to: path, at: position)
        }

        for index in 1...numberOfHorizontalLines {
            let position = CGFloat(index) * horizontalLineSpacing
            addHorizontalLine(to: path, at: position)
        }

        path.lineWidth = lineWidth
        UIColor.white.withAlphaComponent(lineAlpha).setStroke()
        path.stroke()
    }

    // MARK:- Private Methods

    /// Adds a single vertical line to the provided path.
    ///
    /// - Parameters:
    ///   - path: The `UIBezierPath` to add the line to.
    ///   - position: The horizontal position to draw the vertical line at.
    private func addVerticalLine(to path: UIBezierPath, at position: CGFloat) {
        path.move(to: CGPoint(x: position, y: bounds.minY))
        path.addLine(to: CGPoint(x: position, y: bounds.maxY))
    }

    /// Adds a single horizontal line to the provided path.
    ///
    /// - Parameters:
    ///   - path: The `UIBezierPath` to add the line to.
    ///   - position: The vertical position to draw the horizontal line at.
    private func addHorizontalLine(to path: UIBezierPath, at position: CGFloat) {
        path.move(to: CGPoint(x: bounds.minX, y: position))
        path.addLine(to: CGPoint(x: bounds.maxX, y: position))
    }

    /// Initial setup code. Should only be called at initialization.
    private func initSetup() {
        isOpaque = false
        backgroundColor = nil
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .redraw
    }

    // MARK:- Initialization

    /// - Parameters:
    ///   - lineAlpha: The alpha value used for grid lines.
    ///   - lineWidth: The width of the grid lines.
    ///   - numberOfVerticalLines: The number of vertical grid lines to render.
    ///   - numberOfHorizontalLines: The number of horizontal grid lines to render.
    init(lineAlpha: CGFloat = 0.5, lineWidth: CGFloat = 1, numberOfVerticalLines: Int = 2, numberOfHorizontalLines: Int = 3) {

        // Set limits to enforce sensible values.
        self.lineAlpha = lineAlpha.capped(0, 1)
        self.lineWidth = lineWidth.capped(0.33, 3)

        // Set limits to enforce a sensible grid layout.
        let minimumNumberOfGridLinesAllowed = 2
        let maximumNumberOfGridLinesAllowed = 5

        self.numberOfVerticalLines = numberOfVerticalLines.capped(minimumNumberOfGridLinesAllowed, maximumNumberOfGridLinesAllowed)
        self.numberOfHorizontalLines = numberOfHorizontalLines.capped(minimumNumberOfGridLinesAllowed, maximumNumberOfGridLinesAllowed)

        super.init(frame: .zero)
        initSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
