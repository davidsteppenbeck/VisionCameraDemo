//
//  AppearanceManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/04.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

/// A manager that controls the user interface style of the app.
struct AppearanceManager {

    /// Changes the user interface style throughout the entire app.
    static func updateUserInterfaceStyle(for appearance: Appearance) {
        var userInterfaceStyle: UIUserInterfaceStyle {
            switch appearance {
            case .dark: return .dark
            case .light: return .light
            case .system: return .unspecified
            }
        }

        UIApplication.shared.windows.forEach { window in
            if window.overrideUserInterfaceStyle != userInterfaceStyle {
                window.overrideUserInterfaceStyle = userInterfaceStyle
            }
        }
    }

}
