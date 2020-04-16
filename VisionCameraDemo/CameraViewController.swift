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

    private lazy var captureSessionManager = CaptureSessionManager(delegate: self)

    private lazy var cameraView = CameraView(session: captureSessionManager?.session)

    private lazy var cameraButton: CameraButton = {
        let button = CameraButton()
        button.addTarget(self, action: #selector(cameraButtonTapped(_:)), for: .touchDown)
        return button
    }()

    private lazy var settingsBarButton: UIBarButtonItem = {
        let image = UIImage(systemName: "gear")
        return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsBarButtonTapped(_:)))
    }()

    private lazy var optionsBarButton: UIBarButtonItem = {
        let image = UIImage(systemName: "ellipsis")
        return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(optionsBarButtonTapped(_:)))
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
        cameraView.addSubview(cameraButton)
        addViewLayoutConstraints()
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

    @objc private func cameraButtonTapped(_ sender: UIControl) {
        captureSessionManager?.toggle()
    }

    @objc private func settingsBarButtonTapped(_ sender: UIBarButtonItem) {
        coordinator?.showSettings()
    }

    @objc private func optionsBarButtonTapped(_ sender: UIBarButtonItem) {
        coordinator?.showOptions()
    }

    // MARK:- Methods

    private func addViewLayoutConstraints() {
        NSLayoutConstraint.activate([
            cameraButton.centerXAnchor.constraint(equalTo: cameraView.safeAreaLayoutGuide.centerXAnchor),
            cameraButton.bottomAnchor.constraint(equalTo: cameraView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            cameraButton.heightAnchor.constraint(equalToConstant: 60),
            cameraButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

}
