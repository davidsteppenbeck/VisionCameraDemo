//
//  VideoResolutionTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/08.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
import AVFoundation
@testable import VisionCameraDemo

final class VideoResolutionTests: XCTestCase {

    var sut: VideoResolution!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testPreset() {
        // Should provide the `photo` preset.
        sut = VideoResolution.photo
        // Check the actual value against the expected result.
        XCTAssertEqual(sut.preset, AVCaptureSession.Preset.photo)

        // Should provide the `high` preset.
        sut = VideoResolution.high
        // Check the actual value against the expected result.
        XCTAssertEqual(sut.preset, AVCaptureSession.Preset.high)

        // Should provide the `medium` preset.
        sut = VideoResolution.medium
        // Check the actual value against the expected result.
        XCTAssertEqual(sut.preset, AVCaptureSession.Preset.medium)
    }

}
