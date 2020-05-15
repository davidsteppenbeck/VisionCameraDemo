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
        // The inner circle should be smaller than the outer ring.
        let circleRadius = CameraButton.Constants.circleRadiusRatio
        let ringInnerRadius = CameraButton.Constants.ringInnerRadiusRatio
        
        // Check that the actual values give the expected result.
        XCTAssertGreaterThan(ringInnerRadius, circleRadius)
    }

    func testAnimationScale() {
        // The animation should reduce the size of the inner circle then bring it back to its original size.
        let animationScale = CameraButton.Constants.animationScale

        // Check the actual value against the expected result.
        XCTAssertLessThanOrEqual(animationScale.highlighted, 1)
        XCTAssertLessThanOrEqual(animationScale.normal, 1)
    }

}
