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
        XCTAssertFalse(sut.isCameraGridViewHidden)
        sut.model.showCameraGrid = false
        XCTAssertTrue(sut.isCameraGridViewHidden)
    }

    func testAddNotificationCenterSubscribers() {
        XCTAssertFalse(sut.isCameraGridViewHidden)
        NotificationCenter.default.post(name: .showCameraGrid, object: nil, value: false)
        XCTAssertTrue(sut.isCameraGridViewHidden)
    }

}
