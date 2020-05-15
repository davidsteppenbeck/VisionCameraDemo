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

final class CameraViewTests: XCTestCase {

    var sut: CameraView!

    override func setUp() {
        super.setUp()

        // Create a session to inject into the camera view.
        let session = CaptureSessionManager(videoResolution: .high, saveSnapshots: true)!.captureSession
        sut = CameraView(session: session)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSession() {
        // The capture session manager should not be nil. This test will fail if the tests run on the simulator.
        let session = sut.session

        // Check the actual value against the expected result.
        XCTAssertNotNil(session, "Run the tests on a real device with a camera.")
    }

    func testPreview() {
        // The view's preview layer should not be nil.
        let preview = sut.preview

        // Check the actual value against the expected result.
        XCTAssertNotNil(preview)
    }

    func testLayerType() {
        // The view's preview layer should be of type `AVCaptureVideoPreviewLayer`.
        XCTAssertTrue(sut.layer is AVCaptureVideoPreviewLayer)
    }

    func testVideoGravity() {
        // The video gravity should maintain the aspect ratio and fill the screen.
        let videoGravity = sut.preview!.videoGravity

        // Check the actual value against the expected result.
        XCTAssertEqual(videoGravity, AVLayerVideoGravity.resizeAspectFill)
    }

    func testVideoOrientation() {
        // The video orientation should be portrait.
        let videoOrientation = sut.preview!.connection!.videoOrientation

        // Check the actual value against the expected result.
        XCTAssertEqual(videoOrientation, AVCaptureVideoOrientation.portrait)
    }

}
