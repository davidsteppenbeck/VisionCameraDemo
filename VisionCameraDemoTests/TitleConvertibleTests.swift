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
        // Create a title convertable instance.
        let sut: TitleConvertible = MockTitleConvertible()

        // Should be equal to the value returned by the `title` property.
        let title = sut.title

        // Check the actual value against the expected result.
        XCTAssertEqual(title, "A Title")
    }

}

fileprivate struct MockTitleConvertible: TitleConvertible {

    var title: String {
        return "A Title"
    }

}
