//
//  SettingsModelFactory.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/01.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension SettingsModel {

    /// Creates and returns an instance of `SettingsModel` by loading parameters from `UserDefaults`.
    static func makeForUserDefaults(title: String = NSLocalizedString("SETTINGS", comment: "Settings.")) -> SettingsModel {
        return SettingsModel(
            title: title,
            showCameraGrid: UserDefaults.showCameraGrid,
            saveSnapshots: UserDefaults.saveSnapshots,
            videoResolution: UserDefaults.videoResolution,
            appearance: UserDefaults.appearance
        )
    }

}
