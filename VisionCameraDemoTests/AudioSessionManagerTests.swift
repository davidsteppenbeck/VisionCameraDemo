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
        let expected: SystemSoundID = 1119
        XCTAssertEqual(AudioSessionManager.Style.cameraShutter.rawValue, expected)
    }

}
