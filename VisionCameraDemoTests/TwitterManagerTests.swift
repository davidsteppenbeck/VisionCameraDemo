//
//  TwitterManagerTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/04/24.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class TwitterManagerTests: XCTestCase {

    var sut: TwitterManager!

    override func setUp() {
        super.setUp()
        sut = TwitterManager.shared
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testScreenName() {
        // The screen name property should provide a non-empty string.
        let screenName = sut.screenName

        // Check the actual value against the expected result.
        XCTAssertFalse(screenName.isEmpty)
    }

    func testHandle() {
        // The handle property should provide the screen name prefixed with the `@` symbol.
        let handle = sut.handle

        // Check the actual value against the expected result.
        XCTAssertEqual(handle, "@" + sut.screenName)
    }

    func testAppUrl() {
        // The app URL should not be nil.
        let appUrl = sut.url(for: .app)

        // Check the actual value against the expected result.
        XCTAssertNotNil(appUrl)
    }

    func testWebUrl() throws {
        // The web URL should not be nil.
        let webUrl = try XCTUnwrap(sut.url(for: .web))

        // Create an expectation to fulfill.
        let dataExpectation = expectation(description: "Data expectation.")

        // Create a data task for the URL that allows the expectation to fulfill if successful.
        let dataTask = URLSession.shared.dataTask(with: webUrl) { data, response, error in
            if error == nil, data != nil {
                dataExpectation.fulfill()
            }
        }

        // Start the data task.
        dataTask.resume()

        // Wait for the expectation to fulfill.
        waitForExpectations(timeout: 10)
    }

}
