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

    var sut: SettingsModel!

    override func setUp() {
        super.setUp()
        sut = SettingsModel(title: "title", showCameraGrid: true, saveSnapshots: false, videoResolution: .high, appearance: .system)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertEqual(sut.title, "title")
        XCTAssertTrue(sut.showCameraGrid)
        XCTAssertFalse(sut.saveSnapshots)
        XCTAssertEqual(sut.videoResolution, VideoResolution.high)
        XCTAssertEqual(sut.appearance, Appearance.system)
    }

}
