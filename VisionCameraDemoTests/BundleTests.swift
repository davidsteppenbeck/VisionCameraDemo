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
        let appName = try XCTUnwrap(Bundle.main.appName)
        XCTAssertFalse(appName.isEmpty)
    }

    func testAppVersion() throws {
        let appVersion = try XCTUnwrap(Bundle.main.appVersion)
        XCTAssertFalse(appVersion.isEmpty)
    }

    func testAppBuildNumber() throws {
        let appBuildNumber = try XCTUnwrap(Bundle.main.appBuildNumber)
        XCTAssertFalse(appBuildNumber.isEmpty)
    }

}
