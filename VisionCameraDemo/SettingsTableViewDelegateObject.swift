//
//  SettingsTableViewDelegateObject.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/24.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

final class SettingsTableViewDelegateObject: NSObject, UITableViewDelegate {

    // MARK:- Properties

    weak var tableViewController: SettingsTableViewController?

    weak var coordinator: SettingsTableViewControllerCoordinator?

    // MARK:- UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let cell = tableView.cellForRow(at: indexPath), let reuseIdentifier = cell.reuseIdentifier else {
            return
        }

        switch reuseIdentifier {
        case "grid": break
        case "save": break
        case "resolution": break
        case "appearance": break
        case "twitter": coordinator?.openTwitter(from: tableViewController)
        case "feedback": break
        case "system": coordinator?.openSystemSettings()
        default: break
        }
    }

    // MARK:- Initialization

    /// - Parameters:
    ///   - coordinator: The `SettingsTableViewControllerCoordinator` object that the delegate will communicate with.
    ///   The delegate only keeps a `weak` reference to `coordinator`.
    ///   - tableViewController: The `SettingsTableViewController` object that the delegate will communicate with.
    ///   The delegate only keeps a `weak` reference to `tableViewController`.
    init(coordinator: SettingsTableViewControllerCoordinator?, tableViewController: SettingsTableViewController?) {
        self.tableViewController = tableViewController
        self.coordinator = coordinator
        super.init()
    }

    deinit {
        print("delegate deinit")
    }
}
