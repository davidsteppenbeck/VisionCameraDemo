//
//  Bundle+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/13.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension Bundle {

    /// Provides the application's name.
    ///
    /// Uses the bundle's `infoDictionary` with key `CFBundleName`.
    var appName: String? {
        return infoDictionary?["CFBundleName"] as? String
    }

    /// Provides the application's version.
    ///
    /// Uses the bundle's `infoDictionary` with key `CFBundleShortVersionString`.
    var appVersion: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    /// Provides the application's build number.
    ///
    /// Uses the bundle's `infoDictionary` with key `CFBundleVersion`.
    var appBuildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }

}
