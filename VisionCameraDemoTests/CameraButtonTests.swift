//
//  CameraButtonTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/04/16.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class CameraButtonTests: XCTestCase {

    func testRadii() {
        let circleRadius = CameraButton.Constants.circleRadiusRatio
        let ringInnerRadius = CameraButton.Constants.ringInnerRadiusRatio
        XCTAssertGreaterThan(ringInnerRadius, circleRadius)
    }

}
