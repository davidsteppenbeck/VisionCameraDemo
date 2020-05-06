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

    private lazy var mailComposeDelegate = SettingsMailComposeDelegate()

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

    // MARK:- SettingsTableViewControllerCoordinator

    func dismiss() {
        navigationController.presentingViewController?.dismiss(animated: true) {
            self.parent?.childDidFinish(self)
        }
    }

    func showVideoResolutionOptions(from vc: SettingsTableViewController, sourceView: UIView, sourceRect: CGRect?) {
        let alert = UIAlertController.makeForActionSheet(title: "Preferred Video Resolution")
        alert.configurePopover(sourceView: sourceView, sourceRect: sourceRect)

        for videoResolution in VideoResolution.allCases {
            alert += UIAlertAction(title: videoResolution.title, style: .default) { _ in
                vc.viewModel.videoResolution = videoResolution
            }
        }

        vc.present(alert, animated: true)
    }

    func showAppearanceOptions(from vc: SettingsTableViewController, sourceView: UIView, sourceRect: CGRect?) {
        let alert = UIAlertController.makeForActionSheet()
        alert.configurePopover(sourceView: sourceView, sourceRect: sourceRect)

        for appearance in Appearance.allCases {
            alert += UIAlertAction(title: appearance.title, style: .default) { _ in
                vc.viewModel.appearance = appearance
            }
        }

        vc.present(alert, animated: true)
    }

    func openTwitter(from vc: SettingsTableViewController) {
        if let url = TwitterManager.shared.url(for: .app), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        } else if let url = TwitterManager.shared.url(for: .web) {
            let safari = SFSafariViewController(url: url)
            vc.present(safari, animated: true)
        }
    }

    func provideFeedback(from vc: SettingsTableViewController) {
        guard let mailVC = MFMailComposeViewController.makeForFeedback(mailComposeDelegate: mailComposeDelegate) else {
            let alert = UIAlertController.simpleAlertController(title: "Unable To Compose Mail", message: "The device is not configured to send email from this app.")
            vc.present(alert, animated: true)
            return
        }

        // Must present the mail navigation controller modally.
        vc.present(mailVC, animated: true)
    }

    func openSystemSettings() {
        UIApplication.openSettings()
    }

}
