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
        var array = [0,1]
        array += 2
        XCTAssertEqual(array, [0,1,2])
    }

}
