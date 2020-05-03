//
//  SettingsTableViewController.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/17.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

final class SettingsTableViewController: UITableViewController, Storyboarded {

    // MARK:- IBOutlets

    @IBOutlet weak var showCameraGridSwitch: UISwitch! {
        didSet {
            showCameraGridSwitch.addTarget(self, action: #selector(showCameraGridSwitchValueChanged(_:)), for: .valueChanged)
            showCameraGridSwitch.isOn = viewModel.isShowCameraGridSwitchOn
        }
    }

    @IBOutlet private weak var saveSnapshotsSwitch: UISwitch! {
        didSet {
            saveSnapshotsSwitch.addTarget(self, action: #selector(saveSnapshotsSwitchValueChanged(_:)), for: .valueChanged)
            saveSnapshotsSwitch.isOn = viewModel.isSaveSnapshotsSwitchOn
        }
    }

    // MARK:- Properties

    weak var coordinator: SettingsTableViewControllerCoordinator?

    private var viewModel = SettingsViewModel.makeForUserDefaults()

    private lazy var crossBarButton = UIBarButtonItem.makeForSystemImage("xmark", target: self, action: #selector(crossBarButtonAction(_:)))

    // MARK:- View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = crossBarButton
        title = viewModel.title
    }

    // MARK:- Actions

    @objc private func crossBarButtonAction(_ sender: UIBarButtonItem) {
        coordinator?.dismiss()
    }

    @objc private func showCameraGridSwitchValueChanged(_ sender: UISwitch) {
        viewModel.isShowCameraGridSwitchOn = sender.isOn
    }

    @objc private func saveSnapshotsSwitchValueChanged(_ sender: UISwitch) {
        viewModel.isSaveSnapshotsSwitchOn = sender.isOn
    }

    deinit {
        // TODO: Delete deinit
        print("controller deinit")
    }

}
