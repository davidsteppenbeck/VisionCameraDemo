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
        XCTAssertTrue(sut.textBoundingBoxFrames.isEmpty)
    }

    func testImageProcessingState() {
        XCTAssertEqual(sut.imageProcessingState, ImageProcessingState.inactive)
    }

    func testSampleBuffer() {
        XCTAssertNil(sut.sampleBuffer)
    }

}
