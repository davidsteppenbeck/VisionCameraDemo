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

    func testEmbed() {
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // Should insert `testEmbeddedView` at index 0.
        testEmbeddedSubview.embed(in: container)

        let testEmbeddedSubviewIndex = container.subviews.firstIndex(of: testEmbeddedSubview)!

        XCTAssertEqual(testEmbeddedSubviewIndex, 0)
        XCTAssertEqual(container.subviews.count, 1)
    }

    func testEmbedAtIndexZero() {
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // Embed a subview at index 0.
        UIView().embed(in: container)

        // Index 0 already exists in the subviews property, so `testEmbeddedView` should be successfully inserted at index 0.
        testEmbeddedSubview.embed(in: container, at: 0)

        let testEmbeddedSubviewIndex = container.subviews.firstIndex(of: testEmbeddedSubview)!

        XCTAssertEqual(testEmbeddedSubviewIndex, 0)
        XCTAssertEqual(container.subviews.count, 2)
    }

    func testEmbedAtLargeIndex() {
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // Embed a subview at index 0.
        let subview = UIView()
        subview.embed(in: container)

        // Index 10 does not exist in the subviews property, so `testEmbeddedView` should be inserted at index 1.
        testEmbeddedSubview.embed(in: container, at: 10)

        let subviewIndex = container.subviews.firstIndex(of: subview)!
        let testEmbeddedSubviewIndex = container.subviews.firstIndex(of: testEmbeddedSubview)!

        XCTAssertEqual(subviewIndex, 0)
        XCTAssertEqual(testEmbeddedSubviewIndex, 1)
        XCTAssertEqual(container.subviews.count, 2)
    }

    func testEmbedBetweenIndices() {
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // Embed a subview at index 0.
        let firstSubview = UIView()
        firstSubview.embed(in: container)

        // Embed a subview at index 1.
        let lastSubview = UIView()
        lastSubview.embed(in: container)

        // Index 1 already exists in the subviews property, so `testEmbeddedView` should be successfully inserted at index 1.
        // This shifts `lastSubview` to index 2.
        testEmbeddedSubview.embed(in: container, at: 1)

        let firstSubviewIndex = container.subviews.firstIndex(of: firstSubview)!
        let lastSubviewIndex = container.subviews.firstIndex(of: lastSubview)!
        let testEmbeddedSubviewIndex = container.subviews.firstIndex(of: testEmbeddedSubview)!

        XCTAssertEqual(firstSubviewIndex, 0)
        XCTAssertEqual(lastSubviewIndex, 2)
        XCTAssertEqual(testEmbeddedSubviewIndex, 1)
        XCTAssertEqual(container.subviews.count, 3)
    }

    func testEmbedBelowSiblingSubview() {
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // Embed a subview at index 0.
        let subview = UIView()
        subview.embed(in: container)

        // Object `subview` already exists in the subviews property, so `testEmbeddedView` should be successfully inserted at index 0.
        testEmbeddedSubview.embed(in: container, belowSubview: subview)

        let subviewIndex = container.subviews.firstIndex(of: subview)!
        let testEmbeddedSubviewIndex = container.subviews.firstIndex(of: testEmbeddedSubview)!

        XCTAssertEqual(subviewIndex, 1)
        XCTAssertEqual(testEmbeddedSubviewIndex, 0)
        XCTAssertEqual(container.subviews.count, 2)
    }

    func testEmbedBelowNonSiblingSubview() {
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // Embed a subview at index 0.
        let embeddedSubview = UIView()
        embeddedSubview.embed(in: container)

        // Create a non-embedded subview.
        let nonEmbeddedSubview = UIView()

        // Object `nonEmbeddedSubview` does not exist in the subviews property, so `testEmbeddedView` should be successfully inserted at index 1.
        testEmbeddedSubview.embed(in: container, belowSubview: nonEmbeddedSubview)

        let embeddedSubviewIndex = container.subviews.firstIndex(of: embeddedSubview)!
        let testEmbeddedSubviewIndex = container.subviews.firstIndex(of: testEmbeddedSubview)!

        XCTAssertEqual(embeddedSubviewIndex, 0)
        XCTAssertEqual(testEmbeddedSubviewIndex, 1)
        XCTAssertEqual(container.subviews.count, 2)
    }

}
