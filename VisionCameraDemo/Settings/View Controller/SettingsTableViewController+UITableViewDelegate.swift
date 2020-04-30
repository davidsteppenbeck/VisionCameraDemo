//
//  SettingsTableViewController+UITableViewDelegate.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/29.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

extension SettingsTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let cell = tableView.cellForRow(at: indexPath), let reuseIdentifier = cell.reuseIdentifier else {
            return
        }

        switch reuseIdentifier {
        case "resolution": break
        case "appearance": break
        case "twitter": coordinator?.openTwitter(from: self)
        case "feedback": coordinator?.provideFeedback(from: self)
        case "system": coordinator?.openSystemSettings()
        default: break
        }
    }

}
