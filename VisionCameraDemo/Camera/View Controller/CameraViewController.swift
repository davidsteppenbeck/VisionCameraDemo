//
//  CameraViewController.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/10.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit
import Combine

final class CameraViewController: UIViewController {

    // MARK:- Properties

    weak var coordinator: (ErrorHandlerCoordinator & CameraViewControllerCoordinator)?

    private(set) var viewModel = CameraViewModel.makeForUserDefaults()

    private(set) lazy var captureSessionManager: CameraCaptureSessionManagerConvertible? = CaptureSessionManager.makeForUserDefaults(delegate: self)

    private(set) lazy var cameraView = CameraView(session: captureSessionManager?.captureSession)

    private(set) lazy var cameraGridView = CameraGridView()

    private(set) lazy var cameraButton = CameraButton(target: self, action: #selector(cameraButtonAction(_:)), for: .touchDown)

    private(set) lazy var settingsBarButton = UIBarButtonItem.makeForSystemImage("gear", target: self, action: #selector(settingsBarButtonAction(_:)))

    private(set) lazy var optionsBarButton = UIBarButtonItem.makeForSystemImage("ellipsis", target: self, action: #selector(optionsBarButtonAction(_:)))

    /// An array to keep references to `AnyCancellable` subscribers.
    private var subscriptions = [AnyCancellable]()

    // MARK:- View Lifecycle

    override func loadView() {
        view = cameraView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Bundle.main.appName
        navigationItem.leftBarButtonItem = settingsBarButton
        navigationItem.rightBarButtonItem = optionsBarButton
        cameraGridView.embed(in: cameraView)
        cameraButton.embed(in: cameraView, using: cameraView.safeAreaLayoutGuide, insets: UIView.EmbedInsets(bottom: 20), width: 60, height: 60, centerXOffset: 0)
        addViewModelSubscribers()
        addCaptureSessionSubscribers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSessionManager?.startVideoSession()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSessionManager?.stopVideoSession()
    }

    // MARK:- Methods

    private func addViewModelSubscribers() {
        viewModel.$isCameraGridViewHidden
            .assign(to: \.isHidden, on: cameraGridView)
            .store(in: &subscriptions)
    }

    private func addCaptureSessionSubscribers() {
        captureSessionManager?.captureSession.$isUpdatingCaptureSession
            .map { isUpdating in
                return !isUpdating
            }
            .assign(to: \.isEnabled, on: cameraButton)
            .store(in: &subscriptions)
    }

    // MARK:- Actions

    @objc private func cameraButtonAction(_ sender: UIControl) {
        captureSessionManager?.toggle()
    }

    @objc private func settingsBarButtonAction(_ sender: UIBarButtonItem) {
        coordinator?.showSettings()
    }

    @objc private func optionsBarButtonAction(_ sender: UIBarButtonItem) {
        coordinator?.showOptions(from: self, anchor: sender)
    }

}
