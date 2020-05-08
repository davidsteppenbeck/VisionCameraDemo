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

    private(set) var model: CameraModel

    // MARK:- Properties

    @Published private(set) var isCameraGridViewHidden: Bool

    /// An array to keep references to `AnyCancellable` subscribers.
    private var subscriptions = [AnyCancellable]()

    // MARK:- Methods

    /// Adds subscribers to model property publishers.
    private func addModelSubscribers() {
        model.$showCameraGrid
            .map { showCameraGrid in
                return !showCameraGrid
            }
            .assign(to: \.isCameraGridViewHidden, on: self)
            .store(in: &subscriptions)
    }

    /// Adds subscribers to `NotificationCenter` publishers.
    private func addNotificationCenterSubscribers() {
        NotificationCenter.Publisher(center: .default, name: .showCameraGrid)
            .compactMap { (notification) -> Bool? in
                return notification.userInfo?[notification.name] as? Bool
            }
            .sink { [weak self] showCameraGrid in
                if showCameraGrid != self?.model.showCameraGrid {
                    self?.model.showCameraGrid = showCameraGrid
                }
            }
            .store(in: &subscriptions)
    }

    // MARK:- Initialization

    /// - Parameters:
    ///   - model: The camera model from which the view model updates.
    init(model: CameraModel) {
        self.model = model
        self.isCameraGridViewHidden = !model.showCameraGrid
        addModelSubscribers()
        addNotificationCenterSubscribers()
    }

}
