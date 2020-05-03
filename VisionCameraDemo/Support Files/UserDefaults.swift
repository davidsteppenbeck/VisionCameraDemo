//
//  UserDefaults.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/25.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {

    /// The `UserDefaults` key.
    let key: String

    /// The default value to use when no key-value pair is available in `UserDefaults`.
    let defaultValue: T

    var wrappedValue: T {
        get {
            return UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }

}

extension UserDefaults {

    @UserDefault(key: "show_camera_grid", defaultValue: true)
    static var showCameraGrid: Bool

    @UserDefault(key: "save_snapshots", defaultValue: true)
    static var saveSnapshots: Bool

}
