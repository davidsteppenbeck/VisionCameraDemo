//
//  CAShapeLayerTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class CAShapeLayerTests: XCTestCase {

    func testMakeForTextBoundingBox() {
        // Create dependencies for initialization.
        let frame = CGRect(center: CGPoint(x: 5, y: 10), size: CGSize(width: 100, height: 40))
        let borderWidth: CGFloat = 5
        let borderColor: UIColor = .systemBlue

        // The new shape layer should have all the properties provided by the factory method parameters.
        let sut = CAShapeLayer.makeForTextBoundingBox(frame: frame, borderColor: borderColor, borderWidth: borderWidth)

        // Check the actual value against the expected result.
        XCTAssertEqual(sut.frame, frame)
        XCTAssertEqual(sut.borderWidth, borderWidth)
        XCTAssertEqual(sut.borderColor, borderColor.cgColor)
    }

}
