//
//  MainCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/11.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

final class MainCoordinator: NSObject, Coordinator, ParentCoordinator, ErrorHandlerCoordinator, CameraViewControllerCoordinator {

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
        let vc = CameraViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func handleError(_ error: Error, fromViewController vc: UIViewController) {
        let alert = UIAlertController.simpleAlertController(title: "Unresolved Error", message: error.localizedDescription)
        vc.present(alert, animated: true)
    }

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

    func showOptions() {
        print("showOptions")
    }

}
