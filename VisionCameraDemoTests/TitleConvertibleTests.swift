//
//  TitleConvertibleTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/08.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class TitleConvertibleTests: XCTestCase {

    func testTitle() {
        let testCase = TestCase()
        XCTAssertEqual(testCase.title, "A Title")
    }

}

fileprivate struct TestCase: TitleConvertible {

    var title: String {
        return "A Title"
    }

}
