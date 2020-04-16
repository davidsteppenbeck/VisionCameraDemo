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
        // Test `center` getter
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: 100, height: 100)
        var rect = CGRect(origin: origin, size: size)
        XCTAssertEqual(rect.center, CGPoint(x: 50, y: 50))

        // Test `center` setter
        rect.center = CGPoint(x: 0, y: 0)
        XCTAssertEqual(rect.origin, CGPoint(x: -50, y: -50))
    }

    func testCenterInit() {
        let center = CGPoint(x: 100, y: 100)
        let size = CGSize(width: 50, height: 50)
        let expected = CGPoint(x: 75, y: 75)
        let rect = CGRect(center: center, size: size)
        XCTAssertEqual(rect.origin, expected)
    }

    func testScaledAndCentered() {
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: 100, height: 100)
        let rect = CGRect(origin: origin, size: size)
        let scaledRect = rect.scaledAndCentered(0.5)
        XCTAssertEqual(scaledRect.origin, CGPoint(x: 25, y: 25))
        XCTAssertEqual(scaledRect.center, CGPoint(x: 50, y: 50))
        XCTAssertEqual(scaledRect.size, CGSize(width: 50, height: 50))
    }

}
