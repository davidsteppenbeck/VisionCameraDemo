//
//  CameraCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/11.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

final class CameraCoordinator: NSObject, Coordinator, ParentCoordinator, ErrorHandlerCoordinator, CameraViewControllerCoordinator {

    // MARK:- Properties

    var navigationController: UINavigationController

    var children = [Coordinator & ChildCoordinator]()

    // MARK:- Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    // MARK:- Methods

    func start() {
        // Class `VisionViewController` is a `CameraViewController` subclass that handles the OCR text recognition.
        let vc = VisionViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    // MARK:- CameraViewControllerCoordinator

    func showSettings() {
        // The settings table view controller is presented modally, so it requires its own `UINavigationController`.
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .automatic

        // Create and start the child coordinator.
        let coordinator = SettingsCoordinator(navigationController: navigationController)
        children.append(coordinator)
        coordinator.parent = self
        coordinator.start()

        // Present the new navigation controller modally.
        self.navigationController.present(navigationController, animated: true)
    }

    func showOptions(from vc: UIViewController, anchor: UIBarButtonItem) {
        let alert = UIAlertController.makeForActionSheet()
        alert.configurePopover(anchor: anchor)

        let title = NSLocalizedString("SHARE_GITHUB_REPO_ALERT_ACTION_TITLE", comment: "Share github repo via.")

        alert += UIAlertAction(title: title, style: .default) { [weak self] _ in
            self?.shareGitHubRepoURL(from: vc, anchor: anchor)
        }

        vc.present(alert, animated: true)
    }

    private func shareGitHubRepoURL(from vc: UIViewController, anchor: UIBarButtonItem) {
        let activityItems = [URL(string: "https://github.com/davidsteppenbeck/VisionCameraDemo")!]
        let activity = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activity.configurePopover(anchor: anchor)
        vc.present(activity, animated: true)
    }

}
