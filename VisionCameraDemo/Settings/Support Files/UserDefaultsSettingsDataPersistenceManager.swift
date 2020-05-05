//
//  UserDefaultsSettingsDataPersistenceManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/01.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

/// A `SettingsDataPersistenceManager` that writes its values to `UserDefaults`.
struct UserDefaultsSettingsDataPersistenceManager: SettingsDataPersistenceManager {

    func storeShowCameraGridSetting(_ value: Bool) {
        if value != UserDefaults.showCameraGrid { // TODO: Perform this check inside UserDefaults.
            UserDefaults.showCameraGrid = value
        }
    }

    func storeSaveSnapshotsSetting(_ value: Bool) {
        if value != UserDefaults.saveSnapshots {
            UserDefaults.saveSnapshots = value
        }
    }

    func storeAppearanceSetting(_ value: Appearance) {
        if value != UserDefaults.appearance {
            UserDefaults.appearance = value
        }
    }

}
