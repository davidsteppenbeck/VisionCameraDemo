//
//  SettingsTableViewController.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/17.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit
import Combine

final class SettingsTableViewController: UITableViewController, Storyboarded {

    // MARK:- IBOutlets

    @IBOutlet private(set) weak var showCameraGridSwitch: UISwitch! {
        didSet {
            showCameraGridSwitch.addTarget(self, action: #selector(showCameraGridSwitchValueChanged(_:)), for: .valueChanged)
            showCameraGridSwitch.isOn = viewModel.isShowCameraGridSwitchOn
        }
    }

    @IBOutlet private(set) weak var saveSnapshotsSwitch: UISwitch! {
        didSet {
            saveSnapshotsSwitch.addTarget(self, action: #selector(saveSnapshotsSwitchValueChanged(_:)), for: .valueChanged)
            saveSnapshotsSwitch.isOn = viewModel.isSaveSnapshotsSwitchOn
        }
    }

    @IBOutlet private(set) weak var videoResolutionOptionLabel: UILabel!

    @IBOutlet private(set) weak var appearanceOptionLabel: UILabel!

    // MARK:- Properties

    weak var coordinator: SettingsTableViewControllerCoordinator?

    private(set) var viewModel = SettingsViewModel.makeForUserDefaults()

    private lazy var crossBarButton = UIBarButtonItem.makeForSystemImage("xmark", target: self, action: #selector(crossBarButtonAction(_:)))

    /// An array to keep references to `AnyCancellable` subscribers.
    private var subscriptions = [AnyCancellable]()

    // MARK:- View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = crossBarButton
        title = viewModel.title
        addViewModelSubscribers()
    }

    // MARK:- Methods

    private func addViewModelSubscribers() {
        viewModel.$videoResolutionOptionText
            .assign(to: \.text, on: videoResolutionOptionLabel)
            .store(in: &subscriptions)

        viewModel.$appearanceOptionText
            .assign(to: \.text, on: appearanceOptionLabel)
            .store(in: &subscriptions)
    }

    // MARK:- Actions

    /// The action to execute when `crossBarButton` is tapped.
    @objc private func crossBarButtonAction(_ sender: UIBarButtonItem) {
        coordinator?.dismiss()
    }

    /// The action to execute when the `showCameraGridSwitch` value changes.
    @objc private func showCameraGridSwitchValueChanged(_ sender: UISwitch) {
        viewModel.isShowCameraGridSwitchOn = sender.isOn
    }

    /// The action to execute when the `saveSnapshotsSwitch` value changes.
    @objc private func saveSnapshotsSwitchValueChanged(_ sender: UISwitch) {
        viewModel.isSaveSnapshotsSwitchOn = sender.isOn
    }

}
