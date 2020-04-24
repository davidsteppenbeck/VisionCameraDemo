//
//  UIApplication+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/24.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

extension UIApplication {

    /// Attempts to launch the Settings app and display the app’s custom settings, if it has any.
    static func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }

}
