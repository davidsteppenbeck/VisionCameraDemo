//
//  NotificationCenter+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/02.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension NotificationCenter {

    /// Creates a notification with a given name, sender, and value and posts it to the notification center.
    ///
    /// The method calls the `post(name:object:userInfo:)` method and uses the `name` parameter as a key for
    /// the supplied value within the `userInfo` dictionary.
    ///
    /// - Parameters:
    ///   - name: The name of the notification.
    ///   - object: The object posting the notification.
    ///   - value: The value passed along with the posted notification.
    func post(name: Notification.Name, object: Any?, value: Any) {
        post(name: name, object: object, userInfo: [name : value])
    }

}
