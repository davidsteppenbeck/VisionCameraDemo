//
//  CameraViewController.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/10.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, Storyboarded {

    // MARK:- Properties

    weak var coordinator: MainCoordinator?

    // MARK:- View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Camera"
    }

}
