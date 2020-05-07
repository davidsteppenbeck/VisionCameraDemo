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

    var sut: CameraModel!

    override func setUp() {
        super.setUp()
        sut = CameraModel(showCameraGrid: true)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testShowCameraGrid() {
        XCTAssertTrue(sut.showCameraGrid)
    }

}
