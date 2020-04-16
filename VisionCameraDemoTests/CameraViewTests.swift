//
//  CameraViewTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/04/16.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
import AVFoundation
@testable import VisionCameraDemo

class CameraViewTests: XCTestCase {

    var sut: CameraView!

    override func setUp() {
        super.setUp()
        let session = CaptureSessionManager()?.session
        sut = CameraView(session: session)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSession() {
        XCTAssertNotNil(sut.session)
    }

    func testPreview() {
        XCTAssertNotNil(sut.preview)
    }

    func testLayerType() {
        let layer = sut.layer
        XCTAssertTrue(layer is AVCaptureVideoPreviewLayer)
    }

    func testVideoGravity() {
        let expected = AVLayerVideoGravity.resizeAspectFill
        XCTAssertEqual(sut.preview?.videoGravity, expected)
    }

    func testVideoOrientation() {
        let expected = AVCaptureVideoOrientation.portrait
        XCTAssertEqual(sut.preview?.connection?.videoOrientation, expected)
    }

}
