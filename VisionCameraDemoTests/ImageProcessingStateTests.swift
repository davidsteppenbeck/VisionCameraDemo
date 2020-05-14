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
        let sut = ImageProcessingState.processing
        XCTAssertTrue(sut.isProcessing)
        XCTAssertFalse(sut.isInactive)
    }

    func testInactive() {
        let sut = ImageProcessingState.inactive
        XCTAssertTrue(sut.isInactive)
        XCTAssertFalse(sut.isProcessing)
    }

}
