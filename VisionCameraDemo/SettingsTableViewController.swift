//
//  SettingsTableViewController.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/17.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

final class SettingsTableViewController: UITableViewController, Storyboarded {

    // MARK:- Properties

    weak var coordinator: SettingsTableViewControllerCoordinator?

    private lazy var tableViewDelegate = SettingsTableViewDelegateObject(coordinator: coordinator)

    private lazy var crossBarButton: UIBarButtonItem = {
        let image = UIImage(systemName: "xmark")
        return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(crossBarButtonAction(_:)))
    }()

    // MARK:- View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = crossBarButton
        tableView.delegate = tableViewDelegate
        title = "Settings"
    }

    // MARK:- Actions

    @objc private func crossBarButtonAction(_ sender: UIBarButtonItem) {
        coordinator?.dismiss()
    }

    deinit {
        print("controller deinit")
    }
}
