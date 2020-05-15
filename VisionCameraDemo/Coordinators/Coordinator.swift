//
//  Coordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/11.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

/// A protocol that is required for all coordinators.
protocol Coordinator: class {

    /// The navigation controller associated with the coordinator.
    var navigationController: UINavigationController { get set }

    /// Lets the coordinator take control of the navigation flow.
    func start()

}
