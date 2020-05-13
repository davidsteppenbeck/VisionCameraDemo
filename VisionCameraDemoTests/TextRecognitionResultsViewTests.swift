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
        XCTAssertTrue(sut.allTextBoundingBoxes.isEmpty)
    }

    func testAddBoxes() throws {
        let box = CAShapeLayer()
        let boxes: Set<TextBoundingBox> = [box]
        sut.add(boxes)

        XCTAssertEqual(sut.allTextBoundingBoxes.count, 1)
        XCTAssertEqual(sut.allTextBoundingBoxes.first, box)

        let sublayers = try XCTUnwrap(sut.layer.sublayers)
        XCTAssertEqual(sublayers.count, 1)
        XCTAssertEqual(sublayers.first, box)

        // Adding an empty array parameter should then clear the `allTextBoundingBoxes` array.
        sut.add([])
        XCTAssertTrue(sut.allTextBoundingBoxes.isEmpty)
    }

}
