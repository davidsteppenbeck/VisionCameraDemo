//
//  UserDefaults.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/25.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

protocol UserDefaultPropertyWrapper {

    /// The generic type to store in `UserDefaults`.
    associatedtype T

    /// The key used to store values in `UserDefaults`.
    var key: String { get }

    /// The default value that is provided when no `UserDefaults` stored value is available.
    var defaultValue: T { get }

}

@propertyWrapper
struct UserDefault<T>: UserDefaultPropertyWrapper where T: Equatable {

    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get {
            return UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
        set {
            if newValue != wrappedValue {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }

}

@propertyWrapper
struct RawRepresentableUserDefault<T: RawRepresentable>: UserDefaultPropertyWrapper where T: Equatable {

    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get {
            guard let rawValue = UserDefaults.standard.value(forKey: key) as? T.RawValue, let value = T(rawValue: rawValue) else { return defaultValue }
            return value
        }
        set {
            if newValue != wrappedValue {
                UserDefaults.standard.set(newValue.rawValue, forKey: key)
            }
        }
    }

}

extension UserDefaults {

    @UserDefault(key: "show_camera_grid", defaultValue: true)
    static var showCameraGrid: Bool

    @UserDefault(key: "save_snapshots", defaultValue: true)
    static var saveSnapshots: Bool

    @RawRepresentableUserDefault(key: "appearance", defaultValue: .system)
    static var appearance: Appearance

}
