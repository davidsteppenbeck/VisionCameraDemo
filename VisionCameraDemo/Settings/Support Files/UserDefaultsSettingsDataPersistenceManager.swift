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
        UserDefaults.showCameraGrid = value
    }

    func storeSaveSnapshotsSetting(_ value: Bool) {
        UserDefaults.saveSnapshots = value
    }

    func storeAppearanceSetting(_ value: Appearance) {
        UserDefaults.appearance = value
    }

}
