//
//  SettingsModel.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/30.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

/// Data model for `SettingsTableViewController`.
final class SettingsModel {

    /// The title to display to the user.
    let title: String

    /// Controls the state of the camera grid switch.
    @Published var showCameraGrid: Bool

    /// Controls the state of the save snapshots switch.
    @Published var saveSnapshots: Bool

    init(title: String, showCameraGrid: Bool, saveSnapshots: Bool) {
        self.title = title
        self.showCameraGrid = showCameraGrid
        self.saveSnapshots = saveSnapshots
    }

    deinit {
        // TODO: Delete deinit
        print("SettingsModel deinit")
    }

}
