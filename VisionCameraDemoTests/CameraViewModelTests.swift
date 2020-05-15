//
//  CameraViewModelTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/07.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class CameraViewModelTests: XCTestCase {

    var sut: CameraViewModel!

    override func setUp() {
        super.setUp()
        let model = CameraModel(showCameraGrid: true)
        sut = CameraViewModel(model: model)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testAddModelSubscribers() {
        // The value returned by the view model should be compatible with the initialization parameter.
        XCTAssertFalse(sut.isCameraGridViewHidden)

        // Update the model value to trigger the publisher and subscriber for the `showCameraGrid` model property.
        sut.model.showCameraGrid = false

        // Check the actual value against the expected result.
        XCTAssertTrue(sut.isCameraGridViewHidden)
    }

    func testAddNotificationCenterSubscribers() {
        // The value returned by the view model should be compatible with the initialization parameter.
        XCTAssertFalse(sut.isCameraGridViewHidden)

        // Post a notification to trigger updates to the model.
        NotificationCenter.default.post(name: Notification.Name.showCameraGrid, object: nil, value: false)

        // Check the actual value against the expected result.
        XCTAssertTrue(sut.isCameraGridViewHidden)
    }

    func testCameraViewModelFactory() {
        // The view model values should be the same as those in `UserDefaults`.
        let sut = CameraViewModel.makeForUserDefaults()

        // Check the actual value against the expected result.
        XCTAssertEqual(sut.isCameraGridViewHidden, !UserDefaults.showCameraGrid)
    }

}
