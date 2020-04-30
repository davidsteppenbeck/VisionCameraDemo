//
//  CameraViewController.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/10.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

final class CameraViewController: UIViewController, Storyboarded {

    // MARK:- Properties

    weak var coordinator: (ErrorHandlerCoordinator & CameraViewControllerCoordinator)?

    private lazy var captureSessionManager = CaptureSessionManager(saveSnapshots: UserDefaults.saveSnapshots, delegate: self)

    private (set) lazy var cameraView = CameraView(session: captureSessionManager?.session)

    private (set) lazy var gridView = GridView()

    private (set) lazy var cameraButton: CameraButton = {
        let button = CameraButton()
        button.addTarget(self, action: #selector(cameraButtonAction(_:)), for: .touchDown)
        return button
    }()

    private (set) lazy var settingsBarButton: UIBarButtonItem = {
        let image = UIImage(systemName: "gear")
        return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsBarButtonAction(_:)))
    }()

    private (set) lazy var optionsBarButton: UIBarButtonItem = {
        let image = UIImage(systemName: "ellipsis")
        return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(optionsBarButtonAction(_:)))
    }()

    // MARK:- View Lifecycle

    override func loadView() {
        view = cameraView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Bundle.main.appName
        navigationItem.leftBarButtonItem = settingsBarButton
        navigationItem.rightBarButtonItem = optionsBarButton
        gridView.embed(in: cameraView)
        cameraButton.embed(in: cameraView, using: cameraView.safeAreaLayoutGuide, insets: UIView.EmbedInsets(bottom: 20), width: 60, height: 60, centerXOffset: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSessionManager?.startVideoSession()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSessionManager?.stopVideoSession()
    }

    // MARK:- Actions

    @objc private func cameraButtonAction(_ sender: UIControl) {
        captureSessionManager?.toggle()
    }

    @objc private func settingsBarButtonAction(_ sender: UIBarButtonItem) {
        coordinator?.showSettings()
    }

    @objc private func optionsBarButtonAction(_ sender: UIBarButtonItem) {
        coordinator?.showOptions()
    }

}
