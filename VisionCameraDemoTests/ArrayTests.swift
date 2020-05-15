//
//  ArrayTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/02.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class ArrayTests: XCTestCase {

    func testAppendElementOperator() {
        // Create a mutable array.
        var sut = [0, 1]

        // The += operator should append the rhs as an element to the end of the array.
        sut += 2

        // Check the actual value against the expected result.
        XCTAssertEqual(sut, [0, 1, 2])
    }

}
