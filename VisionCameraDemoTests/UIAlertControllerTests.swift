//
//  UIAlertControllerTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/05.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class UIAlertControllerTests: XCTestCase {

    var sut: UIAlertController!

    func testMakeForActionSheet() {
        sut = UIAlertController.makeForActionSheet()
        XCTAssertNil(sut.title)
        XCTAssertNil(sut.message)
        XCTAssertEqual(sut.preferredStyle, UIAlertController.Style.actionSheet)
    }

}
