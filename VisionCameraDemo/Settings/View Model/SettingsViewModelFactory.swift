//
//  SettingsViewModelFactory.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/01.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension SettingsViewModel {

    /// Creates and returns an instance of `SettingsViewModel` by loading parameters from and storing user preferences in `UserDefaults`.
    static func makeForUserDefaults() -> SettingsViewModel {
        let model = SettingsModel.makeForUserDefaults()
        let dataPersistenceManager = UserDefaultsSettingsDataPersistenceManager()
        return SettingsViewModel(model: model, dataPersistenceManager: dataPersistenceManager)
    }

}
