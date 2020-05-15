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
        // All insets should be nil.
        let none = UIView.EmbedInsets.none
        // Check the actual value against the expected result.
        XCTAssertNil(none.top)
        XCTAssertNil(none.bottom)
        XCTAssertNil(none.leading)
        XCTAssertNil(none.trailing)

        // All insets should be zero.
        let zero = UIView.EmbedInsets.zero
        // Check the actual value against the expected result.
        XCTAssertEqual(zero.top, 0)
        XCTAssertEqual(zero.bottom, 0)
        XCTAssertEqual(zero.leading, 0)
        XCTAssertEqual(zero.trailing, 0)

        // All insets should be set to the parameter provided.
        let all = UIView.EmbedInsets.all(50)
        // Check the actual value against the expected result.
        XCTAssertEqual(all.top, 50)
        XCTAssertEqual(all.bottom, 50)
        XCTAssertEqual(all.leading, 50)
        XCTAssertEqual(all.trailing, 50)
    }

    func testEmbed() throws {
        // Create a container view and subview to embed.
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // Should insert the subview at index 0.
        testEmbeddedSubview.embed(in: container)

        // Check the actual value against the expected result.
        let testEmbeddedSubviewIndex = try XCTUnwrap(container.subviews.firstIndex(of: testEmbeddedSubview))
        XCTAssertEqual(testEmbeddedSubviewIndex, 0)
        XCTAssertEqual(container.subviews.count, 1)
    }

    func testEmbedAtIndexZero() throws {
        // Create a container view and subview to embed.
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // First, embed another subview at index 0.
        UIView().embed(in: container)

        // Index 0 already exists in the subviews property, so `testEmbeddedView` should be successfully inserted at index 0.
        testEmbeddedSubview.embed(in: container, at: 0)

        // Check the actual value against the expected result.
        let testEmbeddedSubviewIndex = try XCTUnwrap(container.subviews.firstIndex(of: testEmbeddedSubview))
        XCTAssertEqual(testEmbeddedSubviewIndex, 0)
        XCTAssertEqual(container.subviews.count, 2)
    }

    func testEmbedAtLargeIndex() throws {
        // Create a container view and subview to embed.
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // First, embed another subview at index 0.
        let subview = UIView()
        subview.embed(in: container)

        // Index 10 does not exist in the subviews property, so `testEmbeddedView` should be inserted at index 1.
        testEmbeddedSubview.embed(in: container, at: 10)

        // Check the actual value against the expected result.
        XCTAssertEqual(container.subviews.count, 2)
        let subviewIndex = try XCTUnwrap(container.subviews.firstIndex(of: subview))
        XCTAssertEqual(subviewIndex, 0)
        let testEmbeddedSubviewIndex = try XCTUnwrap(container.subviews.firstIndex(of: testEmbeddedSubview))
        XCTAssertEqual(testEmbeddedSubviewIndex, 1)
    }

    func testEmbedBetweenIndices() throws {
        // Create a container view and subview to embed.
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // First, embed another subview at index 0.
        let firstSubview = UIView()
        firstSubview.embed(in: container)

        // Then embed another subview at index 1.
        let lastSubview = UIView()
        lastSubview.embed(in: container)

        // Indices 0 and 1 already exist in the subviews property, so `testEmbeddedView` should be successfully inserted at index 1.
        // This should shift `lastSubview` to index 2.
        testEmbeddedSubview.embed(in: container, at: 1)

        // Check the actual value against the expected result.
        XCTAssertEqual(container.subviews.count, 3)
        let firstSubviewIndex = try XCTUnwrap(container.subviews.firstIndex(of: firstSubview))
        XCTAssertEqual(firstSubviewIndex, 0)
        let lastSubviewIndex = try XCTUnwrap(container.subviews.firstIndex(of: lastSubview))
        XCTAssertEqual(lastSubviewIndex, 2)
        let testEmbeddedSubviewIndex = try XCTUnwrap(container.subviews.firstIndex(of: testEmbeddedSubview))
        XCTAssertEqual(testEmbeddedSubviewIndex, 1)
    }

    func testEmbedBelowSiblingSubview() throws {
        // Create a container view and subview to embed.
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // First, embed another subview at index 0.
        let subview = UIView()
        subview.embed(in: container)

        // The object named `subview` already exists in the subviews property.
        // Therefore `testEmbeddedView` should be successfully inserted below it, at index 0.
        testEmbeddedSubview.embed(in: container, belowSubview: subview)

        // Check the actual value against the expected result.
        XCTAssertEqual(container.subviews.count, 2)
        let subviewIndex = try XCTUnwrap(container.subviews.firstIndex(of: subview))
        XCTAssertEqual(subviewIndex, 1)
        let testEmbeddedSubviewIndex = try XCTUnwrap(container.subviews.firstIndex(of: testEmbeddedSubview))
        XCTAssertEqual(testEmbeddedSubviewIndex, 0)
    }

    func testEmbedBelowNonSiblingSubview() throws {
        // Create a container view and subview to embed.
        let container = UIView()
        let testEmbeddedSubview = UIView()

        // First, embed another subview at index 0.
        let embeddedSubview = UIView()
        embeddedSubview.embed(in: container)

        // Create another subview that is not embedded in the container.
        let nonEmbeddedSubview = UIView()

        // The object named `nonEmbeddedSubview` does not exist in the subviews property.
        // By default, `testEmbeddedView` should be successfully inserted above all other subviews, at index 1.
        testEmbeddedSubview.embed(in: container, belowSubview: nonEmbeddedSubview)

        // Check the actual value against the expected result.
        XCTAssertEqual(container.subviews.count, 2)
        let embeddedSubviewIndex = try XCTUnwrap(container.subviews.firstIndex(of: embeddedSubview))
        XCTAssertEqual(embeddedSubviewIndex, 0)
        let testEmbeddedSubviewIndex = try XCTUnwrap(container.subviews.firstIndex(of: testEmbeddedSubview))
        XCTAssertEqual(testEmbeddedSubviewIndex, 1)
    }

}
