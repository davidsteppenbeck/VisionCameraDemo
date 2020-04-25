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

    let key: String

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

    @UserDefault(key: "showCameraGrid", defaultValue: true)
    static var showCameraGrid: Bool

    @UserDefault(key: "saveSnapshots", defaultValue: true)
    static var saveSnapshots: Bool

}
