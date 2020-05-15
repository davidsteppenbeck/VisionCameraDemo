//
//  CameraModelTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/07.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class CameraModelTests: XCTestCase {

    func testInitialization() {
        // The stored values should be the same as the initialization parameters.
        let sut = CameraModel(showCameraGrid: true)

        // Check the actual value against the expected result.
        XCTAssertTrue(sut.showCameraGrid)
    }

    func testCameraModelFactory() {
        // The model values should be the same as those in `UserDefaults`.
        let sut = CameraModel.makeForUserDefaults()

        // Check the actual value against the expected result.
        XCTAssertEqual(sut.showCameraGrid, UserDefaults.showCameraGrid)
    }

}
