//
//  NotificationCenterTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/08.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class NotificationCenterTests: XCTestCase {

    var observers: [NSObjectProtocol]!

    override func setUp() {
        super.setUp()
        observers = []
    }

    override func tearDown() {
        if observers != nil {
            for observer in observers {
                NotificationCenter.default.removeObserver(observer)
            }
        }

        observers = nil
        super.tearDown()
    }

    func testPostValue() {
        // Create an expectation to fulfill.
        let notificationExpectation = expectation(description: "Post value notification.")

        // Create a mock notification name.
        let testName = Notification.Name("test_name")

        // Add an observer to the mock notification.
        let observer = NotificationCenter.default.addObserver(
            forName: testName,
            object: nil,
            queue: .main,
            using: { notification in
                if let value = notification.userInfo?[testName] as? String {
                    if value == "value" {
                        notificationExpectation.fulfill()
                    }
                }
            }
        )

        // Must keep a reference outside of the scopr so that the observer can be removed in the tear down method.
        observers = [observer]

        // Posting a notification should fulfill the expectation.
        NotificationCenter.default.post(name: testName, object: nil, value: "value")

        // Wait for the expectation to be fulfilled.
        waitForExpectations(timeout: 1)
    }

}
