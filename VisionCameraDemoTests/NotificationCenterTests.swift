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
        let notificationExpectation = expectation(description: "Post value notification.")

        let testName = Notification.Name("test_name")

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

        // Keep a reference so that it can be removed in the tear down method.
        observers = [observer]

        NotificationCenter.default.post(name: testName, object: nil, value: "value")
        waitForExpectations(timeout: 1)
    }

}
