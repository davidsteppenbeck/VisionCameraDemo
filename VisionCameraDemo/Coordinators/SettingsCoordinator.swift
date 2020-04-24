//
//  SettingsCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/17.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

final class SettingsCoordinator: NSObject, UIAdaptivePresentationControllerDelegate, Coordinator, ChildCoordinator, SettingsTableViewControllerCoordinator {

    // MARK:- Properties

    var navigationController: UINavigationController

    weak var parent: ParentCoordinator?

    private lazy var mailComposeDelegate = SettingsMailComposeDelegateObject()

    // MARK:- Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    // MARK:- UIAdaptivePresentationControllerDelegate

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        parent?.childDidFinish(self)
    }

    // MARK:- Methods

    func start() {
        let vc = SettingsTableViewController.instantiate(withStoryboardName: "Settings")
        vc.coordinator = self
        navigationController.presentationController?.delegate = self
        navigationController.pushViewController(vc, animated: false)
    }

    func dismiss() {
        navigationController.presentingViewController?.dismiss(animated: true) {
            self.parent?.childDidFinish(self)
        }
    }

    func openTwitter(from vc: UIViewController?) {
        let twitter = TwitterManager()

        if let url = twitter.url(for: .app), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        } else if let url = twitter.url(for: .web) {
            let safari = SFSafariViewController(url: url)
            vc?.present(safari, animated: true)
        }
    }

    func provideFeedback(from vc: UIViewController?) {
        guard MFMailComposeViewController.canSendMail() else {
            let alert = UIAlertController.simpleAlertController(title: "Unable To Compose Mail", message: "The device is not configured to send email from this app.")
            vc?.present(alert, animated: true)
            return
        }

        // Create the mail composer.
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = mailComposeDelegate
        mailVC.setToRecipients(["LazyCatApps+VisionCameraDemo@gmail.com"])
        mailVC.setSubject("VisionCameraDemo feedback")
        mailVC.setMessageBody("We'd love to know what you think of the demo!", isHTML: false)

        // Present the new navigation controller modally.
        navigationController.present(mailVC, animated: true)
    }

    func openSystemSettings() {
        UIApplication.openSettings()
    }

    deinit {
        print("coordinator deinit")
    }
}
