//
//  ImageProcessingStateTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/13.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class ImageProcessingStateTests: XCTestCase {

    func testProcessing() {
        // Create an image processing state.
        let sut = ImageProcessingState.processing

        // Check the actual value against the expected result.
        XCTAssertTrue(sut.isProcessing)
        XCTAssertFalse(sut.isInactive)
    }

    func testInactive() {
        // Create an image processing state.
        let sut = ImageProcessingState.inactive

        // Check the actual value against the expected result.
        XCTAssertTrue(sut.isInactive)
        XCTAssertFalse(sut.isProcessing)
    }

}
