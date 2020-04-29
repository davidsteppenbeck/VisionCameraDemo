//
//  MFMailComposeViewControllerFactory.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/29.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import MessageUI

extension MFMailComposeViewController {

    /// Factory method for creating `MFMailComposeViewController` that is configured for providing user feedback.
    ///
    /// - Parameters:
    ///   - mailComposeDelegate: The `MFMailComposeViewControllerDelegate` for the mail compose view controller.
    ///
    /// - Returns: The configured `MFMailComposeViewController` if the current device is able to send email. Otherwise returns `nil`.
    static func makeForFeedback(mailComposeDelegate: MFMailComposeViewControllerDelegate?) -> MFMailComposeViewController? {
        guard MFMailComposeViewController.canSendMail() else {
            return nil
        }

        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = mailComposeDelegate
        mailVC.setToRecipients(["LazyCatApps+VisionCameraDemo@gmail.com"])
        mailVC.setSubject("VisionCameraDemo feedback")
        mailVC.setMessageBody("We'd love to know what you think of the demo!", isHTML: false)
        return mailVC
    }

}
