//
//  SettingsModel.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/30.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

/// Data model for `SettingsTableViewController`.
final class SettingsModel: TitleConvertible {

    let title: String

    /// Controls the state of the camera grid switch.
    @Published var showCameraGrid: Bool

    /// Controls the state of the save snapshots switch.
    @Published var saveSnapshots: Bool

    /// Controls the state of the app's appearance.
    @Published var appearance: Appearance

    init(title: String, showCameraGrid: Bool, saveSnapshots: Bool, appearance: Appearance) {
        self.title = title
        self.showCameraGrid = showCameraGrid
        self.saveSnapshots = saveSnapshots
        self.appearance = appearance
    }

    deinit {
        // TODO: Delete deinit
        print("SettingsModel deinit")
    }

}
