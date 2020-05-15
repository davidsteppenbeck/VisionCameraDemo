//
//  CGRectTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/04/16.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class CGRectTests: XCTestCase {

    func testCenter() {
        // Test `center` getter: It should return the center point of the rectangle calculated using its origin and size.
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: 100, height: 100)
        var rect = CGRect(origin: origin, size: size)
        // Check the actual value against the expected result.
        XCTAssertEqual(rect.center, CGPoint(x: 50, y: 50))

        // Test `center` setter: It should assign the origin a new value calculated from the center point and size.
        rect.center = CGPoint(x: 0, y: 0)
        // Check the actual value against the expected result.
        XCTAssertEqual(rect.origin, CGPoint(x: -50, y: -50))
    }

    func testCenterInitializer() {
        // Create dependencies for initialization.
        let center = CGPoint(x: 100, y: 100)
        let size = CGSize(width: 50, height: 50)

        // Should assign the origin a value calculated from the center point and size.
        let rect = CGRect(center: center, size: size)

        // Check the actual value against the expected result.
        XCTAssertEqual(rect.origin, CGPoint(x: 75, y: 75))
    }

    func testScaledAndCentered() {
        // Create dependencies for initialization.
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: 100, height: 100)

        // Create a rectangle.
        let rect = CGRect(origin: origin, size: size)
        // Check the initial center point against the expected result.
        XCTAssertEqual(rect.center, CGPoint(x: 50, y: 50))

        // Should scale the rectangle's size by the provided scale factor whilst maintaining the original center point.
        let scaledRect = rect.scaledAndCentered(0.5)

        // Check the actual value against the expected result.
        XCTAssertEqual(scaledRect.origin, CGPoint(x: 25, y: 25))
        XCTAssertEqual(scaledRect.center, CGPoint(x: 50, y: 50))
        XCTAssertEqual(scaledRect.size, CGSize(width: 50, height: 50))
    }

}
