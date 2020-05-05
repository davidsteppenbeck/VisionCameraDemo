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
        let sut = UIAlertAction.makeForCancel()
        XCTAssertEqual(sut.style, UIAlertAction.Style.cancel)
    }

}
