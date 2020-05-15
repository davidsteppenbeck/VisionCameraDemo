//
//  VisionTextRecognitionManagerTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/13.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class VisionTextRecognitionManagerTests: XCTestCase {

    var sut: VisionTextRecognitionManager!

    override func setUp() {
        super.setUp()
        sut = VisionTextRecognitionManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testTextBoundingBoxFrames() {
        // The bounding box frames collection should be empty following initialization.
        let isEmpty = sut.textBoundingBoxFrames.isEmpty

        // Check the actual value against the expected result.
        XCTAssertTrue(isEmpty)
    }

    func testImageProcessingState() {
        // The image processing state should be `inactive` following initialization.
        let imageProcessingState = sut.imageProcessingState

        // Check the actual value against the expected result.
        XCTAssertEqual(imageProcessingState, ImageProcessingState.inactive)
    }

    func testSampleBuffer() {
        // The sample buffer should not be set following initialization.
        XCTAssertNil(sut.sampleBuffer)
    }

}
