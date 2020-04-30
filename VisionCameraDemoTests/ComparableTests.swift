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

    func testCappedInt() {
        var result = 1.capped(3, 4)
        var expected = 3
        XCTAssertEqual(result, expected)
        
        result = 3.capped(4, 3)
        expected = 3
        XCTAssertEqual(result, expected)

        result = 6.capped(3, 4)
        expected = 4
        XCTAssertEqual(result, expected)
        
        result = 4.capped(4, 2)
        expected = 4
        XCTAssertEqual(result, expected)

        result = 7.capped(8, 3)
        expected = 7
        XCTAssertEqual(result, expected)
    }

    func testCappedString() {
        let result = "a".capped("c", "j")
        let expected = "c"
        XCTAssertEqual(result, expected)
    }

}
