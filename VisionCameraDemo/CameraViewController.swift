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

    private lazy var settingsBarButton: UIBarButtonItem = {
        let image = UIImage(systemName: "gear")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsBarButtonTapped(_:)))
        return button
    }()

    private lazy var optionsBarButton: UIBarButtonItem = {
        let image = UIImage(systemName: "ellipsis")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(optionsBarButtonTapped(_:)))
        return button
    }()

    // MARK:- View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "VisionCameraDemo"
        navigationItem.leftBarButtonItem = settingsBarButton
        navigationItem.rightBarButtonItem = optionsBarButton
    }

    // MARK:- Actions

    @objc private func settingsBarButtonTapped(_ sender: UIBarButtonItem) {
        coordinator?.showSettings()
    }

    @objc private func optionsBarButtonTapped(_ sender: UIBarButtonItem) {
        coordinator?.showOptions()
    }

}
