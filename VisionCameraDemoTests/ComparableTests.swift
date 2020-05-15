//
//  ComparableTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/04/29.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class ComparableTests: XCTestCase {

    var sut: Int!

    func testCappedInt() {
        // Should cap the value to the lower limit.
        sut = 1.capped(3, 4)
        // Check the actual value against the expected result.
        XCTAssertEqual(sut, 3)

        // Should maintain the value because it lies on or within the limits.
        sut = 3.capped(4, 3)
        // Check the actual value against the expected result.
        XCTAssertEqual(sut, 3)

        // Should cap the value to the upper limit.
        sut = 6.capped(3, 4)
        // Check the actual value against the expected result.
        XCTAssertEqual(sut, 4)

        // Should maintain the value because it lies on or within the limits.
        sut = 4.capped(4, 2)
        // Check the actual value against the expected result.
        XCTAssertEqual(sut, 4)

        // Should maintain the value because it lies on or within the limits.
        sut = 7.capped(8, 3)
        // Check the actual value against the expected result.
        XCTAssertEqual(sut, 7)
    }

    func testCappedString() {
        // Should cap the value to the lower limit.
        let sut = "a".capped("c", "j")

        // Check the actual value against the expected result.
        XCTAssertEqual(sut, "c")
    }

}
