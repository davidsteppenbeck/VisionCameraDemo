//
//  CaptureSessionManagerTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/04/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

class CaptureSessionManagerTests: XCTestCase {

    var sut: CaptureSessionManager!

    override func setUp() {
        super.setUp()
        sut = CaptureSessionManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testCaptureSessionManager() {
        XCTAssertNotNil(sut, "The `CaptureSessionManager` object should not be nil. Run the tests on a real device with a camera.")
    }

    func testSampleBuffer() {
        XCTAssertNil(sut.sampleBuffer)
    }

    func testDidSnapPhoto() {
        XCTAssertFalse(sut.didSnapPhoto)
    }

    func testSessionRunning() {
        XCTAssertFalse(sut.session.isRunning)
    }

    func testUpdateCaptureSessionPreset() {
        XCTAssertEqual(sut.session.sessionPreset, .high)

        let resultChange = sut.updateCaptureSessionPreset(.medium)
        XCTAssertTrue(resultChange)

        let resultNoChange = sut.updateCaptureSessionPreset(.medium)
        XCTAssertFalse(resultNoChange)
    }

}
