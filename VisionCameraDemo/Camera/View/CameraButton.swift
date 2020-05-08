//
//  CameraButton.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/16.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//
//  Code adapted from work of WeTransfer on 2020/04/16.
//  https://github.com/WeTransfer/WeScan
//

import UIKit

/// An animated button used to toggle the camera video session.
final class CameraButton: UIControl {

    // MARK:- Types

    private struct AnimationKeys {
        static let transform = "transform"
    }

    // MARK:- Properties

    /// The outer ring layer.
    private let ringLayer = CAShapeLayer()

    /// The inner circle layer.
    private let circleLayer = CAShapeLayer()

    /// The background circle layer.
    private let backgroundLayer = CAShapeLayer()

    /// The transfrom to apply to the non-highlighted state.
    private let animationNormalScale = CATransform3DMakeScale(Constants.animationScale.normal, Constants.animationScale.normal, Constants.animationScale.normal)

    /// The transfrom to apply to the highlighted state.
    private let animationHighlightedScale = CATransform3DMakeScale(Constants.animationScale.highlighted, Constants.animationScale.highlighted, Constants.animationScale.highlighted)

    // MARK:- Overridden Properties

    override var isHighlighted: Bool {
        didSet {
            if oldValue != isHighlighted {
                animateCircleLayer(forState: isHighlighted)
            }
        }
    }

    // MARK:- Overridden Methods

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        ringLayer.frame = rect
        ringLayer.path = ringLayerPath(for: rect)
        ringLayer.fillColor = Colors.fillColor.cgColor
        ringLayer.rasterizationScale = UIScreen.main.scale
        ringLayer.shouldRasterize = true

        circleLayer.frame = rect
        circleLayer.path = circleLayerPath(for: rect)
        circleLayer.fillColor = Colors.fillColor.cgColor
        circleLayer.rasterizationScale = UIScreen.main.scale
        circleLayer.shouldRasterize = true

        backgroundLayer.frame = rect
        backgroundLayer.path = backgroundLayerPath(for: rect)
        backgroundLayer.fillColor = Colors.backgroundColor.cgColor
        backgroundLayer.rasterizationScale = UIScreen.main.scale
        backgroundLayer.shouldRasterize = true
    }

    // MARK:- Private Methods

    /// Calls to this method will animate the inner circle of the button.
    ///
    /// - Parameters:
    ///   - isHighlighted: Whether or not the button is currently highlighted. Provide the `UIControl` property `isHighlighted`.
    private func animateCircleLayer(forState isHighlighted: Bool) {
        let animation = CAKeyframeAnimation(keyPath: AnimationKeys.transform)
        animation.values = isHighlighted ? [animationNormalScale, animationHighlightedScale] : [animationHighlightedScale, animationNormalScale]
        animation.duration = isHighlighted ? Constants.animationDuration.highlighted : Constants.animationDuration.normal
        animation.isRemovedOnCompletion = false
        animation.fillMode = .both
        circleLayer.add(animation, forKey: AnimationKeys.transform)
    }

    /// Creates a `CGPath` for the outer ring layer.
    ///
    /// - Parameters:
    ///   - rect: The rectangle that contains the path.
    ///
    /// - Returns: A `CGPath` describing the outer ring layer.
    private func ringLayerPath(for rect: CGRect) -> CGPath {
        let innerRect = rect.scaledAndCentered(Constants.ringInnerRadiusRatio)
        let innerPath = UIBezierPath(ovalIn: innerRect).reversing()
        let outerPath = UIBezierPath(ovalIn: rect)
        outerPath.append(innerPath)
        return outerPath.cgPath
    }

    /// Creates a `CGPath` for the inner circle layer.
    ///
    /// - Parameters:
    ///   - rect: The rectangle that contains the path.
    ///
    /// - Returns: A `CGPath` describing the inner circle layer.
    private func circleLayerPath(for rect: CGRect) -> CGPath {
        let rect = rect.scaledAndCentered(Constants.circleRadiusRatio)
        let path = UIBezierPath(ovalIn: rect)
        return path.cgPath
    }

    /// Creates a `CGPath` for the background circle layer.
    ///
    /// - Parameters:
    ///   - rect: The rectangle that contains the path.
    ///
    /// - Returns: A `CGPath` describing the background circle layer.
    private func backgroundLayerPath(for rect: CGRect) -> CGPath {
        let rect = rect.scaledAndCentered(Constants.ringInnerRadiusRatio)
        let path = UIBezierPath(ovalIn: rect)
        return path.cgPath
    }

    /// Initial setup code. Should only be called at initialization.
    private func initSetup() {
        isOpaque = false
        contentMode = .redraw
        backgroundColor = .clear
        isAccessibilityElement = true
        accessibilityTraits = .button
        translatesAutoresizingMaskIntoConstraints = false
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(circleLayer)
        layer.addSublayer(ringLayer)
    }

    // MARK:- Initialization

    convenience init() {
        self.init(frame: .zero)
    }

    convenience init(target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        self.init(frame: .zero)
        self.addTarget(target, action: action, for: controlEvents)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("\(#file) \(#function) \(#line): init(coder:) has not been implemented.")
    }

}

extension CameraButton {
    struct Constants {
        static let circleRadiusRatio: CGFloat = 0.775
        static let ringInnerRadiusRatio: CGFloat = 0.825 // should be greater than `circleRadiusRatio`
        static let animationDuration: (highlighted: TimeInterval, normal: TimeInterval) = (0.1, 0.33) // seconds
        static let animationScale: (highlighted: CGFloat, normal: CGFloat) = (0.85, 1.0)
    }

    struct Colors {
        static let fillColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static let backgroundColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
