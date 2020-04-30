//
//  UIViewTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/04/30.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class UIViewTests: XCTestCase {

    func testEmbedInsets() {
        let none = UIView.EmbedInsets.none
        XCTAssertNil(none.top)
        XCTAssertNil(none.bottom)
        XCTAssertNil(none.leading)
        XCTAssertNil(none.trailing)

        let zero = UIView.EmbedInsets.zero
        XCTAssertEqual(zero.top, 0)
        XCTAssertEqual(zero.bottom, 0)
        XCTAssertEqual(zero.leading, 0)
        XCTAssertEqual(zero.trailing, 0)

        let all = UIView.EmbedInsets.all(50)
        XCTAssertEqual(all.top, 50)
        XCTAssertEqual(all.bottom, 50)
        XCTAssertEqual(all.leading, 50)
        XCTAssertEqual(all.trailing, 50)
    }

}
