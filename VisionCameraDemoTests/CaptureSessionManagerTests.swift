//
//  CaptureSessionManagerTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/04/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class CaptureSessionManagerTests: XCTestCase {

    var sut: CaptureSessionManager!

    override func setUp() {
        super.setUp()
        sut = CaptureSessionManager(videoResolution: .high, saveSnapshots: true)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testCaptureSessionManager() {
        XCTAssertNotNil(sut, "Run the tests on a real device with a camera.")
    }

    func testToggle() {
        XCTAssertFalse(sut.didSnapPhoto)
        sut.toggleVideoSession()
        XCTAssertTrue(sut.didSnapPhoto)
    }

    func testSessionRunning() {
        XCTAssertFalse(sut.captureSession.isRunning)
    }

}
