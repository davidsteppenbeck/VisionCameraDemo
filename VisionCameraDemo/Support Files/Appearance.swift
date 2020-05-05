//
//  Appearance.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/04.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

/// Provides options for the app's appearance.
enum Appearance: String {

    /// Use dark mode irrespective of the system setting.
    case dark

    /// Use light mode irrespective of the system setting.
    case light

    /// Match the system setting.
    case system

}

extension Appearance: CustomStringConvertible {

    var description: String {
        return rawValue
    }

}
