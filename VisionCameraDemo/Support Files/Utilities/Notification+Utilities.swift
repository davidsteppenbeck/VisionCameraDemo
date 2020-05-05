//
//  Notification+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/29.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension Notification.Name {

    /// Use to communicate changes that occur in the user's preference to show the camera grid.
    static let showCameraGrid = Notification.Name("show_camera_grid")

    /// Use to communicate changes that occur in the user's preference to save photos.
    static let saveSnapshots = Notification.Name("save_snapshots")

    /// Use to communicate changes that occur in the user's video resolution preference.
    static let videoResolution = Notification.Name("video_resolution")

}
