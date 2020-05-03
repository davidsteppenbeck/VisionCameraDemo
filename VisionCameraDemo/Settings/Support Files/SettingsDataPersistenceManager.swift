//
//  SettingsDataPersistenceManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/01.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

/// A manager for writing the user's settings data.
protocol SettingsDataPersistenceManager {

    /// Writes the user setting for showing the camera grid.
    func storeShowCameraGridSetting(_ value: Bool)

    /// Writes the user setting for saving snapshots.
    func storeSaveSnapshotsSetting(_ value: Bool)

}
