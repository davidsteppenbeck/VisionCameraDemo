//
//  CameraAuthorizationManagerTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
import AVFoundation
@testable import VisionCameraDemo

final class CameraAuthorizationManagerTests: XCTestCase {

    func testStatus() {
        // The `status` property should return the value from `AVCaptureDevice.authorizationStatus` for media type video.
        let sut = CameraAuthorizationManager()

        // Check the actual value against the expected result.
        XCTAssertEqual(sut.status, AVCaptureDevice.authorizationStatus(for: .video))
    }

}
