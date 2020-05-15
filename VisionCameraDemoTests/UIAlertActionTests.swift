//
//  UIAlertActionTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/05.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class UIAlertActionTests: XCTestCase {

    func testMakeForCancel() {
        // Should create an alert action with the cancel style.
        let sut = UIAlertAction.makeForCancel()
        let style = sut.style

        // Check the actual value against the expected result.
        XCTAssertEqual(style, UIAlertAction.Style.cancel)
    }

}
