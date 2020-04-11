//
//  MainCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/11.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinated {

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

}
