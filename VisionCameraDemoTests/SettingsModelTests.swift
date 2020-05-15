//
//  SettingsModelTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/07.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class SettingsModelTests: XCTestCase {

    func testInitialization() {
        // The model values should be the same as those provided in the initializer.
        let sut = SettingsModel(title: "title", showCameraGrid: true, saveSnapshots: false, videoResolution: .high, appearance: .system)

        // Check the actual value against the expected result.
        XCTAssertEqual(sut.title, "title")
        XCTAssertTrue(sut.showCameraGrid)
        XCTAssertFalse(sut.saveSnapshots)
        XCTAssertEqual(sut.videoResolution, VideoResolution.high)
        XCTAssertEqual(sut.appearance, Appearance.system)
    }

    func testMakeForUserDefaults() {
        // The model values should be the same as those in `UserDefaults`.
        let sut = SettingsModel.makeForUserDefaults()

        // Check the actual value against the expected result.
        XCTAssertEqual(sut.showCameraGrid, UserDefaults.showCameraGrid)
        XCTAssertEqual(sut.saveSnapshots, UserDefaults.saveSnapshots)
        XCTAssertEqual(sut.videoResolution, UserDefaults.videoResolution)
        XCTAssertEqual(sut.appearance, UserDefaults.appearance)
    }

}
