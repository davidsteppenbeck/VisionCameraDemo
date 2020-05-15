//
//  TextRecognitionResultsViewTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/13.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class TextRecognitionResultsViewTests: XCTestCase {

    var sut: TextRecognitionResultsView!

    override func setUp() {
        super.setUp()
        sut = TextRecognitionResultsView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testAllTextBoundingBoxes() {
        // The text bounding boxes collection should be empty following initialization.
        let allTextBoundingBoxes = sut.allTextBoundingBoxes

        // Check the actual value against the expected result.
        XCTAssertTrue(allTextBoundingBoxes.isEmpty)
    }

    func testSublayers() {
        // There should be no sublayers following initialization.
        let sublayers = sut.layer.sublayers

        // Check the actual value against the expected result.
        XCTAssertNil(sublayers)
    }

    func testAddBoxes() throws {
        // Create a "box" to add to the view.
        let box = CAShapeLayer()
        let boxes: Set<TextBoundingBox> = [box]

        // Should add the boxes in the collection to the view as sublayers.
        sut.add(boxes)

        // Check the actual value against the expected result.
        let sublayers = try XCTUnwrap(sut.layer.sublayers)
        XCTAssertEqual(sublayers.count, 1)
        XCTAssertEqual(sublayers.first, box)
        XCTAssertEqual(sut.allTextBoundingBoxes.count, 1)
        XCTAssertEqual(sut.allTextBoundingBoxes.first, box)

        // Adding an empty set should then clear all the "boxes" from the collection and the view.
        sut.add([])

        // Check the actual value against the expected result.
        XCTAssertNil(sut.layer.sublayers)
        XCTAssertTrue(sut.allTextBoundingBoxes.isEmpty)
    }

}
