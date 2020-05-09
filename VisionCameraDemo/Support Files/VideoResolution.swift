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
        case .photo: return NSLocalizedString("USE_PHOTO_QUALITY_RESOLUTION_TITLE", comment: "Photo quality.")
        case .high: return NSLocalizedString("USE_HIGH_QUALITY_RESOLUTION_TITLE", comment: "High quality.")
        case .medium: return NSLocalizedString("USE_MEDIUM_QUALITY_RESOLUTION_TITLE", comment: "Medium quality.")
        }
    }

}

extension VideoResolution: CustomStringConvertible {

    var description: String {
        switch self {
        case .photo: return NSLocalizedString("USE_PHOTO_QUALITY_RESOLUTION_DESCRIPTION", comment: "Photo.")
        case .high: return NSLocalizedString("USE_HIGH_QUALITY_RESOLUTION_DESCRIPTION", comment: "High.")
        case .medium: return NSLocalizedString("USE_MEDIUM_QUALITY_RESOLUTION_DESCRIPTION", comment: "Medium.")
        }
    }

}
