//
//  VideoResolution.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/05.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import AVFoundation

/// Provides options for the video resolution setting.
enum VideoResolution: String, CaseIterable {

    /// Use photo quality video resolution.
    case photo

    /// Use high quality video resolution.
    case high

    /// Use medium quality video resolution.
    case medium

    /// The associated `AVCaptureSession.Preset` value.
    var preset: AVCaptureSession.Preset {
        switch self {
        case .photo: return .photo
        case .high: return .high
        case .medium: return .medium
        }
    }

    /// The default video resolution.
    static let defaultValue = VideoResolution.high

}

extension VideoResolution: TitleConvertible {

    var title: String {
        switch self {
        case .photo: return "Photo Quality"
        case .high: return "High Quality"
        case .medium: return "Medium Quality"
        }
    }

}

extension VideoResolution: CustomStringConvertible {

    var description: String {
        return rawValue
    }

}
