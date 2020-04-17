//
//  AudioSessionManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/17.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

struct AudioSessionManager {

    // MARK:- Types

    /// Provides identifiers for system sounds.
    enum Style: SystemSoundID {

        /// The sound ID used for the camera shutter effect.
        case cameraShutter = 1119

    }

    // MARK:- Methods

    /// Asks the system to play the sound associated with `Style`.
    ///
    /// - Parameters:
    ///   - style: The sound to play.
    static func playSound(withStyle style: Style) {
        if AVAudioSession.sharedInstance().category != .ambient {
            try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
        }

        AudioServicesPlaySystemSound(style.rawValue)
    }

}
