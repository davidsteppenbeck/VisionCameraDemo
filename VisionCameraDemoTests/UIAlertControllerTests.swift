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

    func testMakeForActionSheet() {
        let sut = UIAlertController.makeForActionSheet()
        XCTAssertNil(sut.title)
        XCTAssertNil(sut.message)
        XCTAssertEqual(sut.preferredStyle, UIAlertController.Style.actionSheet)

        // Should add the cancel action by default.
        XCTAssertEqual(sut.actions.count, 1)
        XCTAssertEqual(sut.actions.first!.style, UIAlertAction.Style.cancel)
    }

    func testAddActionStaticMethod() {
        let sut = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        XCTAssertEqual(sut.actions.count, 0)
        sut += UIAlertAction(title: "Title", style: .default, handler: nil)
        XCTAssertEqual(sut.actions.count, 1)
    }

}
