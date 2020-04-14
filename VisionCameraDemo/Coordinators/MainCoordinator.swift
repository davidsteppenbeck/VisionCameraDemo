//
//  MainCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/11.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinated, ErrorHandlerCoordinator, CameraViewControllerCoordinator {

    // MARK:- Properties

    var navigationController: UINavigationController

    var children = [Coordinated]()

    // MARK:- Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        print("showSettings")
    }
    
    func showOptions() {
        print("showOptions")
    }

}
