//
//  CameraViewModel.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/30.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation
import Combine

final class CameraViewModel {

    // MARK:- Model

    var model: CameraModel

    // MARK:- Properties

    @Published var isCameraGridViewHidden: Bool

    /// An array to keep references to `AnyCancellable` subscribers.
    private var tokens = [AnyCancellable]()

    // MARK:- Methods

    private func addModelSubscribers() {
        tokens += model.$showCameraGrid
            .map { !$0 }
            .assign(to: \.isCameraGridViewHidden, on: self)
    }

    /// Adds `NotificationCenter` observers.
    func addNotificationCenterObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateShowCameraGrid(_:)), name: .showCameraGrid, object: nil)
    }

    /// Removes `NotificationCenter` observers.
    func removeNotificationCenterObservers() {
        NotificationCenter.default.removeObserver(self, name: .showCameraGrid, object: nil)
    }

    // MARK:- Actions

    @objc private func updateShowCameraGrid(_ notification: Notification) {

        // Uses the notification name as the dictionary key.
        guard let showCameraGrid = notification.userInfo?[notification.name] as? Bool else {
            return
        }

        if showCameraGrid != model.showCameraGrid {
            model.showCameraGrid = showCameraGrid
        }
    }

    // MARK:- Initialization

    init(model: CameraModel) {
        self.model = model
        self.isCameraGridViewHidden = !model.showCameraGrid
        addModelSubscribers()
        addNotificationCenterObservers()
    }

    // MARK:- Deinitialization

    deinit {
        removeNotificationCenterObservers()
    }

}
