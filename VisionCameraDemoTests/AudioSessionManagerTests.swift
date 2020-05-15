//
//  AudioSessionManagerTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/04/17.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
import AVFoundation
@testable import VisionCameraDemo

final class AudioSessionManagerTests: XCTestCase {

    func testCameraShutterID() {
        // The enum case raw value should be the system sound ID for the standard camera shutter.
        let sut = AudioSessionManager.Style.cameraShutter.rawValue

        // Check the actual value against the expected result.
        XCTAssertEqual(sut, 1108)
    }

    func testSentMailID() {
        // The enum case raw value should be the system sound ID for the standard camera shutter.
        let sut = AudioSessionManager.Style.sentMail.rawValue

        // Check the actual value against the expected result.
        XCTAssertEqual(sut, 1001)
    }

}
