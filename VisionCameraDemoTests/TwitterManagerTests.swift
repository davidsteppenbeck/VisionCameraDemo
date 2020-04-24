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
        sut = TwitterManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testScreenName() {
        XCTAssertFalse(TwitterManager.screenName.isEmpty)
    }

    func testHandle() {
        XCTAssertEqual(TwitterManager.handle, "@" + TwitterManager.screenName)
    }

    func testUrlString() {
        let appUrlString = sut.urlString[.app]
        XCTAssertNotNil(appUrlString)

        let webUrlString = sut.urlString[.web]
        XCTAssertNotNil(webUrlString)
    }

    func testUrl() {
        let appUrl = sut.url(for: .app)
        XCTAssertNotNil(appUrl)

        let webUrl = sut.url(for: .web)
        XCTAssertNotNil(webUrl)
    }

}
