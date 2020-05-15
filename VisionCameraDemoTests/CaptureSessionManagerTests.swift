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
        // The capture session manager should not be nil. This test will fail if the tests run on the simulator.
        XCTAssertNotNil(sut, "Run the tests on a real device with a camera.")
    }

    func testToggleVideoSession() {
        // The initial value of `didSnapPhoto` should be `false`.
        XCTAssertFalse(sut.didSnapPhoto)

        // Toggling the video session should toggle the value of `didSnapPhoto`.
        sut.toggleVideoSession()

        // Check the actual value against the expected result.
        XCTAssertTrue(sut.didSnapPhoto)
    }

    func testSessionRunning() {
        // The capture session should not start running by default.
        let isRunning = sut.captureSession.isRunning

        // Check the actual value against the expected result.
        XCTAssertFalse(isRunning)
    }

    func testMakeForUserDefaults() throws {
        // Create a new manager using initialization parameters from `UserDefaults`.
        let sut = try XCTUnwrap(CaptureSessionManager.makeForUserDefaults())

        // The delegate should not be set with the default initializer.
        XCTAssertNil(sut.delegate)

        // The capture session manager properties should be the same as those in `UserDefaults`.
        let saveSnapshots = sut.saveSnapshots
        // Check the actual value against the expected result.
        XCTAssertEqual(saveSnapshots, UserDefaults.saveSnapshots)
    }

}
