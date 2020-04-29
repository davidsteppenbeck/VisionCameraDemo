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
        let expected: SystemSoundID = 1108
        XCTAssertEqual(AudioSessionManager.Style.cameraShutter.rawValue, expected)
    }

    func testSentMail() {
        let expected: SystemSoundID = 1001
        XCTAssertEqual(AudioSessionManager.Style.sentMail.rawValue, expected)
    }

}
