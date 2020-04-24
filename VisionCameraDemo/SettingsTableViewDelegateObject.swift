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
        case "twitter": break
        case "feedback": break
        case "system": coordinator?.openSystemSettings()
        default: break
        }
    }

    // MARK:- Initialization

    init(coordinator: SettingsTableViewControllerCoordinator?) {
        self.coordinator = coordinator
        super.init()
    }

    deinit {
        print("delegate deinit")
    }
}
