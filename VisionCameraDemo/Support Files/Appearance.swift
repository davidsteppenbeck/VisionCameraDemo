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
        case .dark: return "Always Dark"
        case .light: return "Always Light"
        case .system: return "Match System Style"
        }
    }

}

extension Appearance: CustomStringConvertible {

    var description: String {
        return rawValue
    }

}
