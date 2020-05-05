//
//  CaptureSessionManagerFactory.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/02.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension CaptureSessionManager {

    static func makeForUserDefaults(delegate: CaptureSessionManagerDelegate? = nil) -> CaptureSessionManager? {
        return CaptureSessionManager(
            videoResolution: UserDefaults.videoResolution,
            saveSnapshots: UserDefaults.saveSnapshots,
            delegate: delegate
        )
    }

}
