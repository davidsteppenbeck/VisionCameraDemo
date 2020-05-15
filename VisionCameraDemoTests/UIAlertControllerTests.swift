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

    var title: String!

    var message: String!

    override func setUp() {
        super.setUp()
        title = "Title"
        message = "Message"
    }

    override func tearDown() {
        message = nil
        title = nil
        super.tearDown()
    }

    func testSimpleAlertController() throws {
        // Create the title for the alert action.
        let alertActionText = "OK"

        // Should create an alert controller with the alert style (not the action sheet style) and one alert action attached.
        let sut = UIAlertController.simpleAlertController(title: title, message: message, alertActionText: alertActionText)
        // Check the actual value against the expected result.
        XCTAssertEqual(sut.preferredStyle, UIAlertController.Style.alert)
        XCTAssertEqual(sut.title, title)
        XCTAssertEqual(sut.message, message)
        XCTAssertEqual(sut.actions.count, 1)

        // The alert action that was added should be a default style action.
        let alertAction = try XCTUnwrap(sut.actions.first)
        // Check the actual value against the expected result.
        XCTAssertEqual(alertAction.title, alertActionText)
        XCTAssertEqual(alertAction.style, UIAlertAction.Style.default)
    }

    func testMakeForActionSheet() throws {
        // Should create an alert controller with the action sheet style and the cancel action attached (but no others).
        let sut = UIAlertController.makeForActionSheet(title: title, message: message, addingCancelAction: true)
        // Check the actual value against the expected result.
        XCTAssertEqual(sut.preferredStyle, UIAlertController.Style.actionSheet)
        XCTAssertEqual(sut.title, title)
        XCTAssertEqual(sut.message, message)
        XCTAssertEqual(sut.actions.count, 1)

        // The alert action that was added should be a cancel style action.
        let alertAction = try XCTUnwrap(sut.actions.first)
        // Check the actual value against the expected result.
        XCTAssertEqual(alertAction.style, UIAlertAction.Style.cancel)
    }

    func testAddActionStaticMethod() {
        // Create an alert controller with no actions attached.
        let sut = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Check the actual value against the expected result.
        XCTAssertEqual(sut.actions.count, 0)

        // The += operator should attach the action.
        sut += UIAlertAction(title: title, style: .default, handler: nil)
        // Check the actual value against the expected result.
        XCTAssertEqual(sut.actions.count, 1)
    }

}
