//
//  Bundle+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/13.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension Bundle {

    /// Provides the application name.
    ///
    /// Uses the bundle's `infoDictionary` property with key `CFBundleName`.
    var appName: String? {
        return infoDictionary?["CFBundleName"] as? String
    }

}
