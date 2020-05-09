//
//  Appearance.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/04.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

/// Provides options for the app's appearance setting.
enum Appearance: String, CaseIterable {

    /// Use dark mode irrespective of the system setting.
    case dark

    /// Use light mode irrespective of the system setting.
    case light

    /// Match the system setting.
    case system

}

extension Appearance: TitleConvertible {

    var title: String {
        switch self {
        case .dark: return NSLocalizedString("ALWAYS_USE_DARK_MODE_APPEARANCE_TITLE", comment: "Always dark.")
        case .light: return NSLocalizedString("ALWAYS_USE_LIGHT_MODE_APPEARANCE_TITLE", comment: "Always light.")
        case .system: return NSLocalizedString("USE_SYSTEM_APPEARANCE_TITLE", comment: "System appearance.")
        }
    }

}

extension Appearance: CustomStringConvertible {

    var description: String {
        switch self {
        case .dark: return NSLocalizedString("ALWAYS_USE_DARK_MODE_APPEARANCE_DESCRIPTION", comment: "Dark.")
        case .light: return NSLocalizedString("ALWAYS_USE_LIGHT_MODE_APPEARANCE_DESCRIPTION", comment: "Light.")
        case .system: return NSLocalizedString("USE_SYSTEM_APPEARANCE_DESCRIPTION", comment: "System.")
        }
    }

}
