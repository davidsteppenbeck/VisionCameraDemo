//
//  AudioSessionManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/17.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

/// An `AudioSessionManager` is responsible for playing system sounds.
struct AudioSessionManager {

    // MARK:- Types

    /// Provides identifiers for system sounds.
    enum Style: SystemSoundID {

        /// The sound ID used for the camera shutter effect.
        case cameraShutter = 1108

        /// The sound ID used for the sent mail effect.
        case sentMail = 1001

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
