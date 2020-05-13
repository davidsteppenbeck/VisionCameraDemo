//
//  TextRecognitionResultsView.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/11.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

typealias TextBoundingBox = CAShapeLayer

/// A view for displaying OCR text recognition results as `TextBoundingBox` sublayers.
final class TextRecognitionResultsView: UIView {

    // MARK:- Properties

    /// Stores all the bounding boxes that are currently displayed.
    ///
    /// A "box" represents a single `TextBoundingBox` sublayer.
    private(set) var allTextBoundingBoxes = Set<TextBoundingBox>()

    // MARK:- Methods

    /// Adds the bounding boxes to the view for display.
    ///
    /// - Parameters:
    ///   - boxes: The text bounding boxes to be added.
    func add(_ boxes: Set<TextBoundingBox>) {

        // Ensure that the current boxes are removed before adding new ones.
        removeAllBoundingBoxes()

        // Add the new boxes.
        for box in boxes {
            add(box)
        }
    }

    /// Adds the bounding box to the view for display.
    ///
    /// - Parameters:
    ///   - box: The text bounding box to be added.
    private func add(_ box: TextBoundingBox) {
        allTextBoundingBoxes.insert(box)
        layer.addSublayer(box)
    }

    /// Removes all text bounding boxes from the view.
    ///
    /// Calling this method will remove each box from its superview
    /// and remove all boxes from the `allBoundingBoxes` array.
    private func removeAllBoundingBoxes() {
        for box in allTextBoundingBoxes {
            box.removeFromSuperlayer()
        }

        allTextBoundingBoxes.removeAll()
    }

    // MARK:- Initialization

    init() {
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        backgroundColor = nil
        isOpaque = false
    }

    required init?(coder: NSCoder) {
        fatalError("\(#file) \(#function) \(#line): init(coder:) has not been implemented.")
    }

}
