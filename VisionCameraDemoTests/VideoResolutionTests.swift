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

    func testPreset() {
        XCTAssertEqual(VideoResolution.photo.preset, AVCaptureSession.Preset.photo)
        XCTAssertEqual(VideoResolution.high.preset, AVCaptureSession.Preset.high)
        XCTAssertEqual(VideoResolution.medium.preset, AVCaptureSession.Preset.medium)
    }

}
