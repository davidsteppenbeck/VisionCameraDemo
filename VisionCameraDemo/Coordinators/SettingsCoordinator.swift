//
//  SettingsCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/17.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

final class SettingsCoordinator: NSObject, UIAdaptivePresentationControllerDelegate, Coordinator, ChildCoordinator, SettingsTableViewControllerCoordinator {

    // MARK:- Properties

    var navigationController: UINavigationController

    weak var parent: ParentCoordinator?

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

    func openSystemSettings() {
        UIApplication.openSettings()
    }

    deinit {
        print("coordinator deinit")
    }
}
