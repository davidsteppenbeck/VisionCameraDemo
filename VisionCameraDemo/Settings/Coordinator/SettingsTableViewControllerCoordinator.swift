//
//  SettingsTableViewControllerCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/17.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

protocol SettingsTableViewControllerCoordinator: class {

    /// Call to dismiss the settings table view controller programatically.
    func dismiss()

    /// Presents selectable user interface style options to the user.
    func showAppearanceOptions(from vc: SettingsTableViewController)

    /// Call to take the user out of the app and open the developer's Twitter page.
    func openTwitter(from vc: SettingsTableViewController)

    /// Call to show the email composer that allows the user to provide feedback to the developer.
    func provideFeedback(from vc: SettingsTableViewController)

    /// Call to take the user out of the app and open its system settings.
    func openSystemSettings()

}
