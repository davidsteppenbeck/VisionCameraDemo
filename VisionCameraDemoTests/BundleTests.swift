//
//  BundleTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/04/21.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class BundleTests: XCTestCase {

    func testAppName() throws {
        // Should provide the app name as a string from the main bundle.
        let sut = try XCTUnwrap(Bundle.main.appName)

        // Check the actual value against the expected result.
        XCTAssertFalse(sut.isEmpty)
    }

    func testAppVersion() throws {
        // Should provide the app version number as a string from the main bundle.
        let sut = try XCTUnwrap(Bundle.main.appVersion)

        // Check the actual value against the expected result.
        XCTAssertFalse(sut.isEmpty)
    }

    func testAppBuildNumber() throws {
        // Should provide the app build number as a string from the main bundle.
        let sut = try XCTUnwrap(Bundle.main.appBuildNumber)

        // Check the actual value against the expected result.
        XCTAssertFalse(sut.isEmpty)
    }

}
