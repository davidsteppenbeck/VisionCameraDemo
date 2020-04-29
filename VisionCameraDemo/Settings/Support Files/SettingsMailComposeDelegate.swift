//
//  SettingsMailComposeDelegate.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/24.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import MessageUI

/// A `SettingsMailComposeDelegate` is responsible for handling results from `MFMailComposeViewController`.
final class SettingsMailComposeDelegate: NSObject, MFMailComposeViewControllerDelegate {

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .sent {
            AudioSessionManager.playSound(withStyle: .sentMail)
        }

        controller.presentingViewController?.dismiss(animated: true)
    }

}
