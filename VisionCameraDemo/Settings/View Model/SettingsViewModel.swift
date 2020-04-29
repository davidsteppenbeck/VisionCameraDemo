//
//  SettingsViewModel.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/29.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

/// Controls the state of `SettingsTableViewController`.
final class SettingsViewModel {

    /// Controls the state of the save snapshots switch.
    var isSaveSnapshotsSwitchOn: Bool {
        get {
            return UserDefaults.saveSnapshots
        }
        set {
            let notification = Notification(name: .saveSnapshots, object: self, userInfo: [Notification.Name.saveSnapshots : newValue])
            NotificationCenter.default.post(notification)
            UserDefaults.saveSnapshots = newValue
        }
    }

}
